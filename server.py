#!/usr/bin/env python3
"""
RustSketch Web API Server
Bridges the React vintage UI with the angr and Z3 equivalence checker pipeline.
"""

import os
import sys
import io
import glob
import json
import uuid
import shutil
import tempfile
import contextlib
import re
from typing import Dict, List, Optional, Any, Union
from pathlib import Path


from fastapi import FastAPI, HTTPException, BackgroundTasks
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from fastapi.responses import JSONResponse, PlainTextResponse, FileResponse
from pydantic import BaseModel

# Import rustsketch core
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from rustsketch import run_rustsketch, EquivalenceResult, ReportGenerator

app = FastAPI(
    title="RustSketch Verification Bridge",
    description="REST API for C-to-Rust Semantic Equivalence Checking",
    version="1.0.0"
)

# Enable CORS for development
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

WORKSPACE_ROOT = os.path.dirname(os.path.abspath(__file__))
FIXTURES_DIR = os.path.join(WORKSPACE_ROOT, "tests", "fixtures")
REPORTS_DIR = os.path.join(WORKSPACE_ROOT, "build_rustsketch", "web_reports")
os.makedirs(REPORTS_DIR, exist_ok=True)

# In-memory store for last verification results
LATEST_RUN = {
    "run_id": None,
    "timestamp": None,
    "results": [],
    "log": "",
    "all_equivalent": False,
    "summary": {},
    "c_code": "",
    "rust_code": ""
}


class FileItem(BaseModel):
    path: str
    content: str


def detect_c_pointers(c_source: str) -> bool:
    """Fast pre-scan of C source code to detect pointer arguments in function signatures."""
    if not c_source:
        return False
    func_pattern = re.compile(
        r'\b(?:[a-zA-Z_]\w*[\s*]+)+\b([a-zA-Z_]\w*)\s*\(([^)]*)\)\s*\{',
        re.MULTILINE
    )
    for match in func_pattern.finditer(c_source):
        fname, params = match.group(1), match.group(2)
        if fname == "main":
            continue
        if any("*" in p for p in params.split(",")):
            return True
    return False


class VerifyRequest(BaseModel):
    c_code: Optional[str] = None
    rust_code: Optional[str] = None
    c_path: Optional[str] = None
    rust_path: Optional[str] = None
    c_files: Optional[List[FileItem]] = None
    rust_files: Optional[List[FileItem]] = None
    pointer_mode: Optional[Union[bool, str]] = "auto"
    include_dir: Optional[str] = None


class HarnessRequest(BaseModel):
    function_name: str
    counterexample: Dict[str, Any]
    c_outputs: Optional[Dict[str, Any]] = None
    rust_outputs: Optional[Dict[str, Any]] = None


@app.get("/api/inspect-dir")
def inspect_dir(path: str):
    """Inspects a project folder and returns detected .c, .h, and .rs files."""
    abs_p = path if os.path.isabs(path) else os.path.abspath(os.path.join(WORKSPACE_ROOT, path))
    if not os.path.exists(abs_p):
        raise HTTPException(status_code=404, detail=f"Directory or file '{abs_p}' not found")

    if os.path.isfile(abs_p):
        return {
            "path": abs_p,
            "rel_path": os.path.relpath(abs_p, WORKSPACE_ROOT),
            "is_file": True,
            "filename": os.path.basename(abs_p),
            "size": os.path.getsize(abs_p)
        }

    c_files = sorted(glob.glob(os.path.join(abs_p, "**", "*.c"), recursive=True))
    h_files = sorted(glob.glob(os.path.join(abs_p, "**", "*.h"), recursive=True))
    rs_files = sorted(glob.glob(os.path.join(abs_p, "**", "*.rs"), recursive=True))

    return {
        "path": abs_p,
        "rel_path": os.path.relpath(abs_p, WORKSPACE_ROOT),
        "is_dir": True,
        "c_files": [os.path.relpath(f, abs_p) for f in c_files],
        "h_files": [os.path.relpath(f, abs_p) for f in h_files],
        "rs_files": [os.path.relpath(f, abs_p) for f in rs_files],
        "total_c": len(c_files),
        "total_h": len(h_files),
        "total_rs": len(rs_files)
    }



@app.get("/api/status")
def get_status():
    """Returns the solver and environment status."""
    clang_version = "Unknown"
    rustc_version = "Unknown"
    
    try:
        import subprocess
        clang_res = subprocess.run(["clang", "--version"], capture_output=True, text=True)
        clang_version = clang_res.stdout.splitlines()[0] if clang_res.stdout else "Not found"
    except Exception:
        pass

    try:
        import subprocess
        rustc_res = subprocess.run(["rustc", "--version"], capture_output=True, text=True)
        rustc_version = rustc_res.stdout.splitlines()[0] if rustc_res.stdout else "Not found"
    except Exception:
        pass

    try:
        import z3
        z3_version = z3.get_version_string()
    except Exception:
        z3_version = "Unavailable"

    try:
        import angr
        angr_version = getattr(angr, "__version__", "Available")
    except Exception:
        angr_version = "Unavailable"

    return {
        "status": "online",
        "solvers": {
            "z3": z3_version,
            "angr": angr_version,
            "clang": clang_version,
            "rustc": rustc_version
        },
        "workspace": WORKSPACE_ROOT
    }


@app.get("/api/fixtures")
def get_fixtures():
    """Returns built-in sample benchmarks and test fixtures with their source code."""
    presets = []

    # Fixture 1: Global State Divergence (Buggy)
    f1_c_main = os.path.join(FIXTURES_DIR, "01_global_state_divergence", "c", "main.c")
    f1_c_helper = os.path.join(FIXTURES_DIR, "01_global_state_divergence", "c", "helper.c")
    f1_r_buggy = os.path.join(FIXTURES_DIR, "01_global_state_divergence", "rust_buggy", "src", "main.rs")
    f1_r_fixed = os.path.join(FIXTURES_DIR, "01_global_state_divergence", "rust_fixed", "src", "main.rs")

    # Combine C helper and main into single code block for simple 1-click test
    c1_combined = ""
    if os.path.exists(f1_c_helper) and os.path.exists(f1_c_main):
        with open(f1_c_helper, "r") as f:
            helper_src = f.read().replace('#include "state.h"', "")
        with open(f1_c_main, "r") as f:
            main_src = f.read().replace('#include "state.h"', "")
        c1_combined = (
            "// Global State Divergence Example\n"
            "// C implementation with static global state\n\n"
            + helper_src.strip() + "\n\n" + main_src.strip()
        )

    r1_buggy_src = ""
    if os.path.exists(f1_r_buggy):
        with open(f1_r_buggy, "r") as f:
            r1_buggy_src = f.read()

    r1_fixed_src = ""
    if os.path.exists(f1_r_fixed):
        with open(f1_r_fixed, "r") as f:
            r1_fixed_src = f.read()

    if c1_combined and r1_buggy_src:
        presets.append({
            "id": "01_global_state_buggy",
            "title": "01. Global State Mutation Mismatch (Buggy)",
            "description": "Rust transpilation missed global state persistence and multiplier, causing SAT divergence.",
            "c_code": c1_combined,
            "rust_code": r1_buggy_src,
            "pointer_mode": False,
            "expected_verdict": "SAT (Divergence)",
            "c_path": "tests/fixtures/01_global_state_divergence/c",
            "rust_path": "tests/fixtures/01_global_state_divergence/rust_buggy/src"
        })

    if c1_combined and r1_fixed_src:
        presets.append({
            "id": "01_global_state_fixed",
            "title": "01. Global State Mutation (Fixed / Equivalent)",
            "description": "Rust transpilation correctly tracks static mut state across helpers, proving UNSAT equivalence.",
            "c_code": c1_combined,
            "rust_code": r1_fixed_src,
            "pointer_mode": False,
            "expected_verdict": "UNSAT (Equivalent)",
            "c_path": "tests/fixtures/01_global_state_divergence/c",
            "rust_path": "tests/fixtures/01_global_state_divergence/rust_fixed/src"
        })

    # Fixture 2: Pointer Outparam
    f2_c_main = os.path.join(FIXTURES_DIR, "02_pointer_outparam", "c", "main.c")
    f2_c_helper = os.path.join(FIXTURES_DIR, "02_pointer_outparam", "c", "transform.c")
    f2_r_buggy = os.path.join(FIXTURES_DIR, "02_pointer_outparam", "rust_buggy", "src", "main.rs")
    f2_r_fixed = os.path.join(FIXTURES_DIR, "02_pointer_outparam", "rust_fixed", "src", "main.rs")

    c2_combined = ""
    if os.path.exists(f2_c_helper) and os.path.exists(f2_c_main):
        with open(f2_c_helper, "r") as f:
            h2_src = f.read().replace('#include "transform.h"', "")
        with open(f2_c_main, "r") as f:
            m2_src = f.read().replace('#include "transform.h"', "")
        c2_combined = (
            "// Pointer Out-Parameter Example\n"
            "// C function mutates value via pointer reference\n\n"
            + h2_src.strip() + "\n\n" + m2_src.strip()
        )

    r2_buggy_src = ""
    if os.path.exists(f2_r_buggy):
        with open(f2_r_buggy, "r") as f:
            r2_buggy_src = f.read()

    r2_fixed_src = ""
    if os.path.exists(f2_r_fixed):
        with open(f2_r_fixed, "r") as f:
            r2_fixed_src = f.read()

    if c2_combined and r2_buggy_src:
        presets.append({
            "id": "02_pointer_outparam_buggy",
            "title": "02. Pointer Out-Parameter Mutation (Buggy)",
            "description": "Rust transpiler failed to write back mutated pointer value, resulting in SAT divergence.",
            "c_code": c2_combined,
            "rust_code": r2_buggy_src,
            "pointer_mode": True,
            "expected_verdict": "SAT (Divergence)",
            "c_path": "tests/fixtures/02_pointer_outparam/c",
            "rust_path": "tests/fixtures/02_pointer_outparam/rust_buggy/src"
        })

    if c2_combined and r2_fixed_src:
        presets.append({
            "id": "02_pointer_outparam_fixed",
            "title": "02. Pointer Out-Parameter Mutation (Fixed)",
            "description": "Rust implementation accurately mutates raw pointer out-parameter, proving UNSAT equivalence.",
            "c_code": c2_combined,
            "rust_code": r2_fixed_src,
            "pointer_mode": True,
            "expected_verdict": "UNSAT (Equivalent)",
            "c_path": "tests/fixtures/02_pointer_outparam/c",
            "rust_path": "tests/fixtures/02_pointer_outparam/rust_fixed/src"
        })

    # Benchmark 3: Integer Operations Semantics
    presets.append({
        "id": "03_overflow_semantics",
        "title": "03. Arithmetic Scaling & Inter-procedural Call",
        "description": "Validates arithmetic expression composition and helper parameter pass-through.",
        "c_code": """// Arithmetic Helper and Caller Verification
int helper_calc(int x) {
    return (x * 3) + 7;
}

int caller_calc(int a, int b) {
    return helper_calc(a) + (b * 2);
}

int main() {
    return caller_calc(10, 20);
}
""",
        "rust_code": """// Arithmetic Scaling Transpilation in Rust
#[no_mangle]
pub extern "C" fn helper_calc(x: i32) -> i32 {
    (x * 3) + 7
}

#[no_mangle]
pub extern "C" fn caller_calc(a: i32, b: i32) -> i32 {
    helper_calc(a) + (b * 2)
}

fn main() {
    let res = caller_calc(10, 20);
    std::process::exit(res);
}
""",
        "pointer_mode": False,
        "expected_verdict": "UNSAT (Equivalent)",
        "c_path": None,
        "rust_path": None
    })

    # Discover all C and Rust source directories dynamically
    c_dirs_found = sorted(list(set(
        os.path.dirname(f) for f in glob.glob(f"{WORKSPACE_ROOT}/**/*.c", recursive=True)
        if "build" not in f and "angr_env" not in f and "ui" not in f
    )))
    rs_dirs_found = sorted(list(set(
        os.path.dirname(f) for f in glob.glob(f"{WORKSPACE_ROOT}/**/*.rs", recursive=True)
        if "build" not in f and "angr_env" not in f and "ui" not in f
    )))

    c_directories = [
        {
            "name": os.path.relpath(d, WORKSPACE_ROOT),
            "path": os.path.relpath(d, WORKSPACE_ROOT),
            "abs_path": d,
            "c_files": [os.path.basename(f) for f in sorted(glob.glob(f"{d}/*.c"))],
            "h_files": [os.path.basename(f) for f in sorted(glob.glob(f"{d}/*.h"))]
        }
        for d in c_dirs_found
    ]

    rust_directories = [
        {
            "name": os.path.relpath(d, WORKSPACE_ROOT),
            "path": os.path.relpath(d, WORKSPACE_ROOT),
            "abs_path": d,
            "rs_files": [os.path.basename(f) for f in sorted(glob.glob(f"{d}/*.rs"))]
        }
        for d in rs_dirs_found
    ]

    return {
        "presets": presets,
        "directories": c_directories + rust_directories,
        "c_directories": c_directories,
        "rust_directories": rust_directories
    }


@app.post("/api/verify")
def verify_equivalence(req: VerifyRequest):
    """
    Executes RustSketch inter-procedural equivalence verification.
    Supports:
      1. Two project folder paths (c_path, rust_path)
      2. Uploaded multi-file folders (c_files, rust_files)
      3. Direct C & Rust source code strings (c_code, rust_code)
    """
    global LATEST_RUN
    run_id = str(uuid.uuid4())[:8]
    temp_dir = None
    log_capture = io.StringIO()

    try:
        # Case 1: Uploaded folder files (list of FileItem objects)
        if req.c_files and req.rust_files:
            temp_dir = tempfile.mkdtemp(prefix=f"rustsketch_upload_{run_id}_")
            c_dir = os.path.join(temp_dir, "c_project")
            rust_dir = os.path.join(temp_dir, "rust_project")
            os.makedirs(c_dir, exist_ok=True)
            os.makedirs(rust_dir, exist_ok=True)

            for item in req.c_files:
                target_path = os.path.join(c_dir, os.path.basename(item.path))
                with open(target_path, "w") as f:
                    f.write(item.content)

            for item in req.rust_files:
                target_path = os.path.join(rust_dir, os.path.basename(item.path))
                with open(target_path, "w") as f:
                    f.write(item.content)

            target_c = c_dir
            target_rust = rust_dir
            build_dir = os.path.join(temp_dir, "build")

        # Case 2: Direct source code text in editors
        elif req.c_code is not None and req.rust_code is not None and not req.c_path and not req.rust_path:
            temp_dir = tempfile.mkdtemp(prefix=f"rustsketch_run_{run_id}_")
            c_file = os.path.join(temp_dir, "input.c")
            rust_file = os.path.join(temp_dir, "input.rs")

            with open(c_file, "w") as f:
                f.write(req.c_code)
            with open(rust_file, "w") as f:
                f.write(req.rust_code)

            target_c = c_file
            target_rust = rust_file
            build_dir = os.path.join(temp_dir, "build")

        # Case 3: Two project folder / file paths on disk
        elif req.c_path and req.rust_path:
            target_c = req.c_path if os.path.isabs(req.c_path) else os.path.abspath(os.path.join(WORKSPACE_ROOT, req.c_path))
            target_rust = req.rust_path if os.path.isabs(req.rust_path) else os.path.abspath(os.path.join(WORKSPACE_ROOT, req.rust_path))

            if not os.path.exists(target_c):
                raise HTTPException(status_code=400, detail=f"C source path '{target_c}' does not exist.")
            if not os.path.exists(target_rust):
                raise HTTPException(status_code=400, detail=f"Rust source path '{target_rust}' does not exist.")

            build_dir = os.path.join(WORKSPACE_ROOT, "build_rustsketch", f"run_{run_id}")
        else:
            raise HTTPException(
                status_code=400,
                detail="Must provide either (c_path and rust_path), (c_files and rust_files), or (c_code and rust_code)"
            )


        json_out_path = os.path.join(REPORTS_DIR, f"report_{run_id}.json")
        log_out_path = os.path.join(REPORTS_DIR, f"log_{run_id}.txt")

        # Resolve pointer_mode
        ptr_mode_resolved = None
        if isinstance(req.pointer_mode, str):
            if req.pointer_mode.lower() in ["on", "true"]:
                ptr_mode_resolved = True
            elif req.pointer_mode.lower() in ["off", "false"]:
                ptr_mode_resolved = False
            else:
                ptr_mode_resolved = None  # auto-detect
        elif isinstance(req.pointer_mode, bool):
            ptr_mode_resolved = req.pointer_mode

        # Capture terminal stdout while running rustsketch
        with contextlib.redirect_stdout(log_capture), contextlib.redirect_stderr(log_capture):
            results = run_rustsketch(
                c_path=target_c,
                rust_path=target_rust,
                build_dir=build_dir,
                include_dir=req.include_dir,
                json_report=json_out_path,
                pointer_mode=ptr_mode_resolved
            )

        full_log = log_capture.getvalue()
        
        # Save raw log to file for direct download
        with open(log_out_path, "w") as f:
            f.write(full_log)

        # Parse structured output
        all_eq = all(r.is_equivalent for r in results) if results else False
        serializable_results = []
        for r in results:
            serializable_results.append({
                "function": r.function_name,
                "equivalent": r.is_equivalent,
                "verdict": r.solver_status,
                "details": r.details,
                "counterexample": r.counterexample or {},
                "c_outputs": r.c_outputs or {},
                "rust_outputs": r.rust_outputs or {}
            })

        # Save to latest run cache
        LATEST_RUN = {
            "run_id": run_id,
            "timestamp": os.path.getmtime(json_out_path) if os.path.exists(json_out_path) else None,
            "results": serializable_results,
            "log": full_log,
            "all_equivalent": all_eq,
            "summary": {
                "total_functions": len(results),
                "equivalent_count": sum(1 for r in results if r.is_equivalent),
                "divergent_count": sum(1 for r in results if not r.is_equivalent),
                "overall_verdict": "EQUIVALENT (UNSAT)" if all_eq else "DIVERGENCE DETECTED (SAT)"
            },
            "c_code": req.c_code or "",
            "rust_code": req.rust_code or ""
        }

        return {
            "success": True,
            "run_id": run_id,
            "overall_verdict": "EQUIVALENT (UNSAT)" if all_eq else "DIVERGENCE DETECTED (SAT)",
            "all_equivalent": all_eq,
            "results": serializable_results,
            "log": full_log,
            "summary": LATEST_RUN["summary"]
        }

    except Exception as e:
        error_log = log_capture.getvalue() + f"\n[ERROR] Exception during execution: {str(e)}"
        return {
            "success": False,
            "run_id": run_id,
            "error": str(e),
            "log": error_log,
            "results": [],
            "all_equivalent": False,
            "overall_verdict": "ERROR"
        }
    finally:
        # Clean up temporary directories if created
        if temp_dir and os.path.exists(temp_dir):
            shutil.rmtree(temp_dir, ignore_errors=True)


@app.get("/api/reports/latest")
def get_latest_report():
    """Returns the most recent verification report and log."""
    if not LATEST_RUN["run_id"]:
        existing_report = os.path.join(WORKSPACE_ROOT, "divergence_report.json")
        if os.path.exists(existing_report):
            with open(existing_report, "r") as f:
                data = json.load(f)
            return {
                "run_id": "cached_report",
                "results": data,
                "log": "Loaded from cached divergence_report.json",
                "all_equivalent": all(d.get("equivalent", False) for d in data)
            }
        return {"error": "No verification runs executed yet"}
    return LATEST_RUN


@app.get("/api/download/report/{run_id}")
def download_json_report(run_id: str):
    """Download the JSON equivalence report for a given run."""
    report_file = os.path.join(REPORTS_DIR, f"report_{run_id}.json")
    if not os.path.exists(report_file):
        report_file = os.path.join(WORKSPACE_ROOT, "divergence_report.json")
        if not os.path.exists(report_file):
            raise HTTPException(status_code=404, detail="Report not found")
    return FileResponse(
        report_file,
        media_type="application/json",
        filename=f"rustsketch_divergence_{run_id}.json"
    )


@app.get("/api/download/log/{run_id}")
def download_log(run_id: str):
    """Download the full terminal divergence log for a given run."""
    log_file = os.path.join(REPORTS_DIR, f"log_{run_id}.txt")
    if not os.path.exists(log_file):
        if LATEST_RUN.get("log"):
            return PlainTextResponse(
                LATEST_RUN["log"],
                headers={"Content-Disposition": f"attachment; filename=rustsketch_log_{run_id}.txt"}
            )
        raise HTTPException(status_code=404, detail="Log file not found")
    return FileResponse(
        log_file,
        media_type="text/plain",
        filename=f"rustsketch_log_{run_id}.txt"
    )


@app.post("/api/generate-harness")
def generate_reproducer_harness(req: HarnessRequest):
    """
    Synthesizes standalone runnable C and Rust counterexample test reproduction files
    using the concrete Z3 witness values.
    """
    fn_name = req.function_name
    cex = req.counterexample
    c_out = req.c_outputs or {}
    r_out = req.rust_outputs or {}

    args_list = []
    arg_idx = 0
    while f"arg_{arg_idx}" in cex:
        args_list.append(str(cex[f"arg_{arg_idx}"]))
        arg_idx += 1
    args_str = ", ".join(args_list) if args_list else "/* no arguments */"

    c_harness = f"""/**
 * RustSketch Divergence Witness Test - C Reproducer
 * Function: {fn_name}
 * Counter-Example Values: {json.dumps(cex)}
 */

#include <stdio.h>
#include <assert.h>

// Expected C Return: {c_out.get('return', 'N/A')}
// Expected C Global: {c_out.get('final_global', c_out.get('global_state', 'N/A'))}

extern int {fn_name}({', '.join(['int' for _ in range(len(args_list))]) if args_list else 'void'});

int main() {{
    printf("[RustSketch C Harness] Testing '{fn_name}' with counter-example witness:\\n");
{chr(10).join([f"    printf(\"  • {k} = {v} (hex: 0x{v:x} if applicable)\\n\");" for k, v in cex.items() if isinstance(v, int)])}

    int result = {fn_name}({args_str});
    printf("[RustSketch C Harness] Actual Return = %d\\n", result);
    return 0;
}}
"""

    r_harness = f"""/**
 * RustSketch Divergence Witness Test - Rust Reproducer
 * Function: {fn_name}
 * Counter-Example Values: {json.dumps(cex)}
 */

// Expected Rust Return: {r_out.get('return', 'N/A')}
// Expected Rust Global: {r_out.get('final_global', r_out.get('global_state', 'N/A'))}

extern "C" {{
    fn {fn_name}({', '.join([f'arg{i}: i32' for i in range(len(args_list))])}) -> i32;
}}

fn main() {{
    println!("[RustSketch Rust Harness] Testing '{fn_name}' with counter-example witness:");
{chr(10).join([f"    println!(\"  • {k} = {v} (0x{v:x})\");" for k, v in cex.items() if isinstance(v, int)])}

    unsafe {{
        let result = {fn_name}({args_str});
        println!("[RustSketch Rust Harness] Actual Return = {{}}", result);
    }}
}}
"""

    return {
        "function_name": fn_name,
        "c_harness": c_harness,
        "rust_harness": r_harness,
        "counterexample": cex
    }


# Mount built static assets if available
ui_dist_dir = os.path.join(WORKSPACE_ROOT, "ui", "dist")
if os.path.exists(ui_dist_dir):
    app.mount("/", StaticFiles(directory=ui_dist_dir, html=True), name="static")


if __name__ == "__main__":
    import uvicorn
    print("Starting RustSketch Web Bridge on http://localhost:8000 ...")
    uvicorn.run(app, host="0.0.0.0", port=8000)
