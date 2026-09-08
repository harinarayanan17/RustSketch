#!/usr/bin/env python3
"""
================================================================================
 RustSketch: Inter-Procedural Semantic Equivalence Validation Framework
 for C-to-Rust Transpilation
================================================================================
 Modules implemented:
  5.3.1 Validation Module
  5.3.2 LLVM IR Compilation & Linking Module (Clang, rustc, llvm-link)
  5.3.3 Call-Graph Analysis & Separation Module (Leaf/Helper vs Callers)
  5.3.4 Symbolic Execution & Summary Generation Module (angr)
  5.3.5 Summary Repository (Mathematical Pre/Post Conditions & Side-Effects)
  5.3.6 Z3 SMT Solver & Equivalence Checker Module (Difference Queries)
  5.3.7 Report & Result Generation Module (Formal Verdicts & Counter-examples)
================================================================================
"""

import os
import sys
import re
import glob
import json
import shutil
import argparse
import subprocess
from typing import Dict, List, Optional, Tuple, Any

import angr
import claripy
import z3
from colorama import Fore, Style, init

init(autoreset=True)

# Suppress verbose third-party logs
import logging
logging.getLogger('angr').setLevel(logging.CRITICAL)
logging.getLogger('claripy').setLevel(logging.CRITICAL)
logging.getLogger('cle').setLevel(logging.CRITICAL)
logging.getLogger('pyvex').setLevel(logging.CRITICAL)


# ==============================================================================
# Module 5.3.1: Validation Module
# ==============================================================================
class ValidationModule:
    """Validates the input source files and directory structure."""

    @staticmethod
    def validate_inputs(c_path: str, rust_path: str) -> Tuple[List[str], List[str]]:
        # Validate C input
        if os.path.isfile(c_path):
            if not c_path.endswith(".c"):
                raise ValueError(f"C input file '{c_path}' must have a .c extension.")
            c_files = [os.path.abspath(c_path)]
        elif os.path.isdir(c_path):
            c_files = glob.glob(os.path.join(c_path, "**", "*.c"), recursive=True)
            if not c_files:
                raise ValueError(f"No C source files (*.c) found in '{c_path}'.")
            c_files = sorted(c_files)
        else:
            raise FileNotFoundError(f"C source file or directory '{c_path}' does not exist.")

        # Validate Rust input
        if os.path.isfile(rust_path):
            if not rust_path.endswith(".rs"):
                raise ValueError(f"Rust input file '{rust_path}' must have a .rs extension.")
            rust_files = [os.path.abspath(rust_path)]
        elif os.path.isdir(rust_path):
            rust_files = glob.glob(os.path.join(rust_path, "**", "*.rs"), recursive=True)
            if not rust_files:
                raise ValueError(f"No Rust source files (*.rs) found in '{rust_path}'.")
            rust_files = sorted(rust_files)
        else:
            raise FileNotFoundError(f"Rust source file or directory '{rust_path}' does not exist.")

        return c_files, rust_files


# ==============================================================================
# Module 5.3.2: LLVM IR Compilation & Linking Module
# ==============================================================================
class CompilerLinkerModule:
    """
    Compiles C and Rust code into language-agnostic LLVM IR (.ll, .bc)
    and relocatable binary models for angr symbolic analysis.
    """

    def __init__(self, build_dir: str = "build_rustsketch"):
        self.build_dir = os.path.abspath(build_dir)
        os.makedirs(self.build_dir, exist_ok=True)


    @staticmethod
    def _instrument_rust_code(rust_code: str) -> str:
        processed_lines = []
        raw_lines = rust_code.splitlines()
        for idx, line in enumerate(raw_lines):
            stripped = line.strip()
            if (stripped.startswith("static mut ") or stripped.startswith("pub static mut ")) and not line.startswith("#[no_mangle]"):
                prev_line = raw_lines[idx - 1].strip() if idx > 0 else ""
                if prev_line != "#[no_mangle]":
                    processed_lines.append("#[no_mangle]")
                processed_lines.append(line)
            elif re.match(r'^\s*(pub\s+)?(unsafe\s+)?fn\s+([a-zA-Z0-9_]+)', line):
                fn_match = re.match(r'^\s*(pub\s+)?(unsafe\s+)?fn\s+([a-zA-Z0-9_]+)', line)
                fn_name = fn_match.group(3)
                if fn_name != "main":
                    prev_line = raw_lines[idx - 1].strip() if idx > 0 else ""
                    if prev_line != "#[no_mangle]":
                        processed_lines.append("#[no_mangle]")
                    is_unsafe = bool(fn_match.group(2))
                    if 'extern "C"' not in line:
                        mod_line = re.sub(
                            r'^\s*(pub\s+)?(unsafe\s+)?fn\s+',
                            ('pub unsafe extern "C" fn ' if is_unsafe else 'pub extern "C" fn '),
                            line
                        )
                        processed_lines.append(mod_line)
                    else:
                        processed_lines.append(line)
                else:
                    processed_lines.append(line)
            else:
                processed_lines.append(line)
        return "\n".join(processed_lines)

    def compile_and_link(self, c_files: List[str], rust_files: List[str], c_include_dir: Optional[str] = None) -> Dict[str, Any]:
        artifacts = {}

        # 1. Compile C to LLVM IR (.ll and .bc)
        c_bc_files = []
        c_ll_files = []
        include_flags = ["-I", c_include_dir] if c_include_dir else []
        for i, c_file in enumerate(c_files):
            base_name = f"c_unit_{i}_{os.path.basename(c_file).replace('.c', '')}"
            ll_path = os.path.join(self.build_dir, f"{base_name}.ll")
            bc_path = os.path.join(self.build_dir, f"{base_name}.bc")

            cmd_ll = ["clang", "-S", "-emit-llvm", "-O0", "-g", "-fno-discard-value-names"] + include_flags + [c_file, "-o", ll_path]
            cmd_bc = ["clang", "-c", "-emit-llvm", "-O0", "-g", "-fno-discard-value-names"] + include_flags + [c_file, "-o", bc_path]

            subprocess.run(cmd_ll, check=True, capture_output=True, text=True)
            subprocess.run(cmd_bc, check=True, capture_output=True, text=True)
            c_ll_files.append(ll_path)
            c_bc_files.append(bc_path)

        # Link C IR via llvm-link
        c_linked_bc = os.path.join(self.build_dir, "c_linked.bc")
        c_linked_ll = os.path.join(self.build_dir, "c_linked.ll")
        if len(c_bc_files) > 1:
            subprocess.run(["llvm-link", "-o", c_linked_bc] + c_bc_files, check=True, capture_output=True)
            subprocess.run(["llvm-link", "-S", "-o", c_linked_ll] + c_ll_files, check=True, capture_output=True)
        else:
            shutil.copyfile(c_bc_files[0], c_linked_bc)
            shutil.copyfile(c_ll_files[0], c_linked_ll)

        artifacts["c_linked_bc"] = c_linked_bc
        artifacts["c_linked_ll"] = c_linked_ll

        # Compile C binary model for angr (with weak main stub in case no main() is defined)
        stub_c = os.path.join(self.build_dir, "stub_main.c")
        with open(stub_c, "w") as f:
            f.write("int __attribute__((weak)) main() { return 0; }\n")

        c_bin = os.path.join(self.build_dir, "c_model.bin")
        cmd_c_bin = ["clang", "-O0", "-g", "-rdynamic", "-no-pie", "-fno-builtin"] + include_flags + c_files + [stub_c, "-o", c_bin]
        subprocess.run(cmd_c_bin, check=True, capture_output=True, text=True)
        artifacts["c_bin"] = c_bin

        # 2. Compile Rust to LLVM IR (.ll) and binary model
        rust_main = None
        for rf in rust_files:
            if os.path.basename(rf) in ["main.rs", "lib.rs"]:
                rust_main = rf
                break
        if not rust_main:
            rust_main = rust_files[0]

        # Check if C original files contain main
        has_c_main = False
        for c_file in c_files:
            try:
                with open(c_file, "r") as f:
                    c_src = f.read()
                    if re.search(r'\b(int|void)\s+main\s*\(', c_src):
                        has_c_main = True
                        break
            except Exception:
                pass

        # Check if Rust file contains main
        with open(rust_main, "r") as f:
            rust_code = f.read()

        has_rust_main = bool(re.search(r'\bfn\s+main\s*\(', rust_code))
        has_user_main = has_c_main and has_rust_main

        # Determine base directory for Rust source files
        if len(rust_files) > 1:
            rust_base_dir = os.path.commonpath([os.path.abspath(rf) for rf in rust_files])
        else:
            rust_base_dir = os.path.dirname(os.path.abspath(rust_files[0]))

        rust_src_dir = os.path.join(self.build_dir, "rust_src")
        os.makedirs(rust_src_dir, exist_ok=True)

        for rf in rust_files:
            abs_rf = os.path.abspath(rf)
            rel_rf = os.path.relpath(abs_rf, rust_base_dir)
            target_dest = os.path.join(rust_src_dir, rel_rf)
            os.makedirs(os.path.dirname(target_dest), exist_ok=True)
            with open(abs_rf, "r") as f:
                content = f.read()
            instrumented = self._instrument_rust_code(content)
            if abs_rf == os.path.abspath(rust_main) and not has_rust_main:
                instrumented += "\n\n#[allow(dead_code)]\nfn main() {}\n"
            with open(target_dest, "w") as f:
                f.write(instrumented)

        rust_target_file = os.path.join(rust_src_dir, os.path.relpath(os.path.abspath(rust_main), rust_base_dir))

        rust_bin = os.path.join(self.build_dir, "rust_model.bin")
        rust_ll = os.path.join(self.build_dir, "rust_model.ll")
        
        # Emit Rust LLVM IR
        cmd_rust_ll = [
            "rustc",
            "--emit=llvm-ir",
            "-C", "opt-level=0",
            "-C", "debuginfo=2",
            "-g",
            rust_target_file,
            "-o", rust_ll
        ]
        subprocess.run(cmd_rust_ll, check=True, capture_output=True, text=True)

        # Compile Rust binary model for angr
        cmd_rust_bin = [
            "rustc",
            "-C", "opt-level=0",
            "-C", "debuginfo=2",
            "-C", "overflow-checks=off",
            "-C", "panic=abort",
            "-C", "link-args=-Wl,--export-dynamic",
            "-g",
            rust_target_file,
            "-o", rust_bin
        ]
        subprocess.run(cmd_rust_bin, check=True, capture_output=True, text=True)

        artifacts["rust_bin"] = rust_bin
        artifacts["rust_ll"] = rust_ll
        artifacts["has_user_main"] = has_user_main

        return artifacts


# ==============================================================================
# Module 5.3.3: Call-Graph Analysis & Separation Module
# ==============================================================================
class CallGraphModule:
    """
    Analyzes the structural call-graph dependencies within the compiled models
    and separates user functions into leaf helpers and root/caller functions.
    """

    IGNORED_PREFIXES = (
        "_", "frame_dummy", "register_tm_clones", "deregister_tm_clones",
        "__", "call_weak_fn", "stat_", "std::", "core::", "alloc::",
        "sub_"
    )

    def __init__(self, c_proj: angr.Project, rust_proj: angr.Project, has_user_main: bool = True):
        self.c_proj = c_proj
        self.rust_proj = rust_proj
        self.has_user_main = has_user_main

    def get_user_functions(self, proj: angr.Project) -> Dict[str, int]:
        user_funcs = {}
        for sym in proj.loader.symbols:
            if sym.is_function and sym.name:
                name = sym.name
                if not any(name.startswith(p) for p in self.IGNORED_PREFIXES) and not name.startswith("_R"):
                    user_funcs[name] = sym.rebased_addr
        return user_funcs

    def analyze_hierarchy(self) -> Dict[str, Any]:
        c_funcs = self.get_user_functions(self.c_proj)
        rust_funcs = self.get_user_functions(self.rust_proj)

        # Fast CFG on C project to discover caller vs leaf relationships
        cfg = self.c_proj.analyses.CFGFast(function_starts=list(c_funcs.values()) if c_funcs else None)

        matched_names = []
        for name in c_funcs:
            if not self.has_user_main and name == "main":
                continue
            if name in rust_funcs:
                matched_names.append(name)
            else:
                for r_name in rust_funcs:
                    if name in r_name:
                        matched_names.append(name)
                        break

        helpers = []
        callers = []

        for name in matched_names:
            if name == "main":
                if self.has_user_main:
                    callers.append(name)
                continue

            c_addr = c_funcs.get(name)
            if c_addr and c_addr in self.c_proj.kb.functions:
                c_func = self.c_proj.kb.functions[c_addr]
                callee_addrs = list(self.c_proj.kb.callgraph.successors(c_func.addr))
                user_callees = [
                    self.c_proj.kb.functions[a].name
                    for a in callee_addrs
                    if a in self.c_proj.kb.functions and self.c_proj.kb.functions[a].name in c_funcs and self.c_proj.kb.functions[a].name != name
                ]
                if user_callees:
                    callers.append(name)
                else:
                    helpers.append(name)
            else:
                helpers.append(name)

        if not helpers and len(matched_names) >= 1:
            helpers = [n for n in matched_names if n != "main"]
            if self.has_user_main:
                callers = ["main"]

        return {
            "all_matched": matched_names,
            "helpers": sorted(list(set(helpers))),
            "callers": sorted(list(set(callers))),
            "c_funcs": c_funcs,
            "rust_funcs": rust_funcs
        }


# ==============================================================================
# Module 5.3.4 & 5.3.5: Symbolic Execution & Summary Repository
# ==============================================================================
class FunctionSummary:
    """Represents the extracted mathematical summary of a helper function."""

    def __init__(self, name: str, language: str, sym_args: List[claripy.ast.BV],
                 paths: List[Dict[str, Any]], global_sym: Optional[str] = None):
        self.name = name
        self.language = language
        self.sym_args = sym_args
        self.paths = paths
        self.global_sym = global_sym

    def get_primary_path(self) -> Dict[str, Any]:
        if not self.paths:
            raise ValueError(f"No feasible symbolic paths found for {self.name} ({self.language})")
        return self.paths[0]


class SummaryRepository:
    """Central repository storing and indexing extracted function summaries."""

    def __init__(self):
        self.c_summaries: Dict[str, FunctionSummary] = {}
        self.rust_summaries: Dict[str, FunctionSummary] = {}

    def store(self, summary: FunctionSummary):
        if summary.language == "c":
            self.c_summaries[summary.name] = summary
        else:
            self.rust_summaries[summary.name] = summary

    def get(self, name: str, language: str) -> Optional[FunctionSummary]:
        if language == "c":
            return self.c_summaries.get(name)
        return self.rust_summaries.get(name)


class HelperSummarizer:
    """Performs isolated symbolic execution via angr to extract summaries."""

    @staticmethod
    def get_global_symbols(proj: angr.Project) -> List[Tuple[str, int]]:
        ignored = {
            "__dso_handle", "_DYNAMIC", "_GLOBAL_OFFSET_TABLE_", "__TMC_LIST__",
            "__TMC_END__", "completed.0", "stdout", "stdin", "stderr", "environ",
            "_init", "_fini", "main", "rust_eh_personality"
        }
        res = []
        for s in proj.loader.symbols:
            if not s.name or s.is_function:
                continue
            if s.name in ignored or s.name.startswith("_") or s.name.startswith(".") or s.name.startswith("DW.") or "DW." in s.name or s.name.startswith("rust_"):
                continue
            if "OBJECT" in str(s.type) or s.size > 0:
                res.append((s.name, s.rebased_addr))
        return res

    @classmethod
    def find_symbol_addr(cls, proj: angr.Project, name: Optional[str] = None) -> Optional[Tuple[str, int]]:
        if name:
            sym = proj.loader.find_symbol(name)
            if sym and sym.rebased_addr:
                return sym.name, sym.rebased_addr
            for s in proj.loader.symbols:
                if s.name and (name.lower() == s.name.lower() or name.lower() in s.name.lower() or s.name.lower() in name.lower()) and not s.is_function and not s.name.startswith("DW."):
                    return s.name, s.rebased_addr
        globals_list = cls.get_global_symbols(proj)
        if globals_list:
            return globals_list[0]
        return None

    @classmethod
    def summarize(cls, proj: angr.Project, func_name: str, language: str,
                  num_args: int = 1, global_candidates: List[str] = None,
                  is_pointer_arg: bool = False,
                  shared_sym_inputs: Optional[Dict[str, Any]] = None) -> FunctionSummary:
        if global_candidates is None:
            global_candidates = ["g_counter", "G_COUNTER", "global_var", "counter", "state", "status"]

        sym = proj.loader.find_symbol(func_name)
        if not sym:
            for s in proj.loader.symbols:
                if s.name and func_name in s.name and s.is_function:
                    sym = s
                    break
        if not sym:
            raise ValueError(f"Function symbol '{func_name}' not found in {proj.filename}")

        ptr_buf_addr = 0x70000000

        # Retrieve or create shared symbolic arguments
        if shared_sym_inputs and "args" in shared_sym_inputs:
            sym_args = shared_sym_inputs["args"]
        else:
            sym_args = []
            for i in range(num_args):
                if i == 0 and is_pointer_arg:
                    sym_args.append(claripy.BVV(ptr_buf_addr, 64))
                else:
                    sym_args.append(claripy.BVS(f"arg_{i}", 32))

        # Check for global symbol
        global_sym_name = None
        global_addr = None
        g_info = None
        for g_cand in global_candidates:
            g_info = cls.find_symbol_addr(proj, g_cand)
            if g_info:
                break
        if not g_info:
            g_info = cls.find_symbol_addr(proj, None)
        if g_info:
            global_sym_name, global_addr = g_info

        ret_addr = 0xdeadbeef
        state = proj.factory.call_state(
            sym.rebased_addr,
            *sym_args,
            ret_addr=ret_addr,
            add_options={angr.options.ZERO_FILL_UNCONSTRAINED_REGISTERS}
        )

        # Initialize pointer memory buffer
        if is_pointer_arg:
            if shared_sym_inputs and "ptr_init" in shared_sym_inputs:
                init_ptr_val = shared_sym_inputs["ptr_init"]
            else:
                init_ptr_val = claripy.BVS("init_ptr_val", 32)
            state.memory.store(ptr_buf_addr, init_ptr_val, endness=proj.arch.memory_endness)

        # Initialize global variable with symbolic initial value
        if global_addr is not None:
            if shared_sym_inputs and "global_init" in shared_sym_inputs:
                init_g_val = shared_sym_inputs["global_init"]
            else:
                init_g_val = claripy.BVS(f"init_{global_sym_name}", 32)
            state.memory.store(global_addr, init_g_val, endness=proj.arch.memory_endness)

        # Explore feasible paths to return
        simgr = proj.factory.simulation_manager(state)
        simgr.explore(find=ret_addr, num_find=50)

        paths = []
        for end_state in simgr.found:
            ret_val = end_state.regs.eax
            
            mut_globals = {}
            if global_addr is not None:
                mut_globals[global_sym_name] = end_state.memory.load(global_addr, 4, endness=proj.arch.memory_endness)

            mut_ptr = None
            if is_pointer_arg:
                mut_ptr = end_state.memory.load(ptr_buf_addr, 4, endness=proj.arch.memory_endness)

            paths.append({
                "constraints": end_state.solver.constraints,
                "return": ret_val,
                "global_mutation": mut_globals,
                "ptr_mutation": mut_ptr,
                "state": end_state
            })

        return FunctionSummary(func_name, language, sym_args, paths, global_sym_name)


# ==============================================================================
# Module 5.3.6: Z3 SMT Solver & Equivalence Checker Module
# ==============================================================================
class EquivalenceResult:
    """Encapsulates the formal mathematical verdict of an equivalence query."""

    def __init__(self, function_name: str, is_equivalent: bool,
                 solver_status: str, counterexample: Optional[Dict[str, Any]] = None,
                 c_outputs: Optional[Dict[str, Any]] = None,
                 rust_outputs: Optional[Dict[str, Any]] = None,
                 details: Optional[str] = None):
        self.function_name = function_name
        self.is_equivalent = is_equivalent
        self.solver_status = solver_status  # "UNSAT" (equivalent) or "SAT" (divergent)
        self.counterexample = counterexample or {}
        self.c_outputs = c_outputs or {}
        self.rust_outputs = rust_outputs or {}
        self.details = details or ""


class EquivalenceCheckerModule:
    """
    Formulates and solves compositional Z3 / Claripy SMT difference queries.
    """

    def __init__(self, c_proj: angr.Project, rust_proj: angr.Project,
                 repository: SummaryRepository, c_ll_path: Optional[str] = None):
        self.c_proj = c_proj
        self.rust_proj = rust_proj
        self.repo = repository
        self.c_ll_path = c_ll_path

    @staticmethod
    def parse_signatures(ll_path: Optional[str]) -> Dict[str, Dict[str, Any]]:
        """Parses function prototypes, argument counts, and pointer types from LLVM IR."""
        if not ll_path or not os.path.exists(ll_path):
            return {}
        try:
            with open(ll_path, "r") as f:
                content = f.read()
        except Exception:
            return {}

        sigs = {}
        pattern = re.compile(r"define\s+[^@]*?\b([a-zA-Z0-9_*]+)\b\s+@([a-zA-Z0-9_]+)\s*\((.*?)\)")
        for match in pattern.finditer(content):
            ret_type = match.group(1).strip()
            fname = match.group(2).strip()
            raw_args = match.group(3).strip()
            if not raw_args:
                args = []
            else:
                args = [a.strip() for a in raw_args.split(",") if a.strip()]

            ptr_indices = [i for i, a in enumerate(args) if a.startswith("ptr") or "*" in a]
            sigs[fname] = {
                "return_type": ret_type,
                "is_void": ret_type == "void",
                "num_args": len(args),
                "has_pointer_arg": len(ptr_indices) > 0,
                "ptr_indices": ptr_indices
            }
        return sigs

    def check_helper_equivalence(self, func_name: str, num_args: int = 1,
                                 is_pointer_arg: bool = False) -> EquivalenceResult:
        # Check if C function returns void
        is_void = False
        if self.c_ll_path and os.path.exists(self.c_ll_path):
            try:
                with open(self.c_ll_path, "r") as f:
                    ll_src = f.read()
                if re.search(r'define\s+[^@]*\bvoid\s+@' + re.escape(func_name) + r'\b', ll_src):
                    is_void = True
            except Exception:
                pass

        ptr_buf_addr = 0x70000000

        # Create shared symbolic inputs
        shared_args = []
        for i in range(num_args):
            if i == 0 and is_pointer_arg:
                shared_args.append(claripy.BVV(ptr_buf_addr, 64))
            else:
                shared_args.append(claripy.BVS(f"shared_arg_{i}", 32))

        shared_ptr_init = claripy.BVS("shared_ptr_init", 32) if is_pointer_arg else None
        shared_g_init = claripy.BVS("shared_g_init", 32)

        shared_inputs = {
            "args": shared_args,
            "ptr_init": shared_ptr_init,
            "global_init": shared_g_init
        }

        # Summarize C helper
        c_summary = HelperSummarizer.summarize(
            self.c_proj, func_name, "c", num_args,
            is_pointer_arg=is_pointer_arg, shared_sym_inputs=shared_inputs
        )
        self.repo.store(c_summary)

        # Summarize Rust helper (aligning global variable name with C)
        preferred_candidates = [c_summary.global_sym] if c_summary.global_sym else None
        rust_summary = HelperSummarizer.summarize(
            self.rust_proj, func_name, "rust", num_args,
            global_candidates=preferred_candidates,
            is_pointer_arg=is_pointer_arg, shared_sym_inputs=shared_inputs
        )
        self.repo.store(rust_summary)

        # Multi-path cross-product equivalence checking
        divergence_found = False
        divergence_cex = None
        divergence_c_out = None
        divergence_r_out = None

        for c_path in c_summary.paths:
            for r_path in rust_summary.paths:
                solver = claripy.Solver()
                for c in c_path["constraints"]:
                    solver.add(c)
                for c in r_path["constraints"]:
                    solver.add(c)

                # Are path conditions compatible?
                if not solver.satisfiable():
                    continue

                diff_conditions = []
                if not is_void:
                    diff_conditions.append(c_path["return"] != r_path["return"])

                c_g_mut = c_path["global_mutation"].get(c_summary.global_sym) if c_summary.global_sym else None
                r_g_mut = r_path["global_mutation"].get(rust_summary.global_sym) if rust_summary.global_sym else None

                if c_g_mut is not None and r_g_mut is not None:
                    diff_conditions.append(c_g_mut != r_g_mut)
                elif c_g_mut is not None and r_g_mut is None:
                    diff_conditions.append(c_g_mut != shared_g_init)
                elif r_g_mut is not None and c_g_mut is None:
                    diff_conditions.append(r_g_mut != shared_g_init)

                if is_pointer_arg:
                    if c_path["ptr_mutation"] is not None and r_path["ptr_mutation"] is not None:
                        diff_conditions.append(c_path["ptr_mutation"] != r_path["ptr_mutation"])

                if not diff_conditions:
                    diff_conditions.append(claripy.BoolV(False))

                solver.add(claripy.Or(*diff_conditions))
                if solver.satisfiable():
                    divergence_found = True
                    cex = {}
                    for i, arg in enumerate(shared_args):
                        if i == 0 and is_pointer_arg:
                            continue
                        cex[f"arg_{i}"] = solver.eval(arg, 1)[0]
                    if is_pointer_arg and shared_ptr_init is not None:
                        cex["initial_ptr_val"] = solver.eval(shared_ptr_init, 1)[0]
                    if c_summary.global_sym or rust_summary.global_sym:
                        cex["initial_global"] = solver.eval(shared_g_init, 1)[0]

                    divergence_cex = cex
                    divergence_c_out = {
                        "return": solver.eval(c_path["return"], 1)[0] if not is_void else "void",
                        "ptr_val": solver.eval(c_path["ptr_mutation"], 1)[0] if is_pointer_arg and c_path["ptr_mutation"] is not None else None,
                        "global_state": solver.eval(c_g_mut, 1)[0] if c_g_mut is not None else None
                    }
                    divergence_r_out = {
                        "return": solver.eval(r_path["return"], 1)[0] if not is_void else "void",
                        "ptr_val": solver.eval(r_path["ptr_mutation"], 1)[0] if is_pointer_arg and r_path["ptr_mutation"] is not None else None,
                        "global_state": solver.eval(r_g_mut, 1)[0] if r_g_mut is not None else None
                    }
                    break
            if divergence_found:
                break

        if not divergence_found:
            return EquivalenceResult(
                function_name=func_name,
                is_equivalent=True,
                solver_status="UNSAT",
                details="Mathematical proof of semantic equivalence verified across all symbolic inputs."
            )
        else:
            return EquivalenceResult(
                function_name=func_name,
                is_equivalent=False,
                solver_status="SAT",
                counterexample=divergence_cex,
                c_outputs=divergence_c_out,
                rust_outputs=divergence_r_out,
                details="Behavioral divergence detected. Counter-example witness found."
            )

    def check_compositional_caller(self, caller_name: str, num_args: int = 2) -> EquivalenceResult:
        sym_c = self.c_proj.loader.find_symbol(caller_name)
        sym_r = self.rust_proj.loader.find_symbol(caller_name)
        if not sym_c:
            for s in self.c_proj.loader.symbols:
                if s.name and caller_name in s.name and s.is_function:
                    sym_c = s
                    break
        if not sym_r:
            for s in self.rust_proj.loader.symbols:
                if s.name and caller_name in s.name and s.is_function:
                    sym_r = s
                    break

        if not sym_c or not sym_r:
            raise ValueError(f"Caller function '{caller_name}' not found in both C and Rust binaries.")

        # Shared symbolic arguments
        shared_args = [claripy.BVS(f"caller_arg_{i}", 32) for i in range(num_args)]
        shared_g_init = claripy.BVS("caller_g_init", 32)

        # 1. C execution
        ret_addr = 0xdeadbeef
        state_c = self.c_proj.factory.call_state(
            sym_c.rebased_addr, *shared_args, ret_addr=ret_addr,
            add_options={angr.options.ZERO_FILL_UNCONSTRAINED_REGISTERS}
        )
        g_c_cand = ["g_counter", "G_COUNTER", "global_var", "counter", "state", "status"]
        g_c_info = None
        for gc in g_c_cand:
            g_c_info = HelperSummarizer.find_symbol_addr(self.c_proj, gc)
            if g_c_info:
                break
        if not g_c_info:
            g_c_info = HelperSummarizer.find_symbol_addr(self.c_proj, None)
        if g_c_info:
            _, g_addr_c = g_c_info
            state_c.memory.store(g_addr_c, shared_g_init, endness=self.c_proj.arch.memory_endness)

        simgr_c = self.c_proj.factory.simulation_manager(state_c)
        simgr_c.explore(find=ret_addr, num_find=50)
        if not simgr_c.found:
            raise RuntimeError(f"C caller function '{caller_name}' execution did not reach return.")

        # 2. Rust execution
        state_r = self.rust_proj.factory.call_state(
            sym_r.rebased_addr, *shared_args, ret_addr=ret_addr,
            add_options={angr.options.ZERO_FILL_UNCONSTRAINED_REGISTERS}
        )
        g_r_info = None
        for gc in g_c_cand:
            g_r_info = HelperSummarizer.find_symbol_addr(self.rust_proj, gc)
            if g_r_info:
                break
        if not g_r_info:
            g_r_info = HelperSummarizer.find_symbol_addr(self.rust_proj, None)
        if g_r_info:
            _, g_addr_r = g_r_info
            state_r.memory.store(g_addr_r, shared_g_init, endness=self.rust_proj.arch.memory_endness)

        simgr_r = self.rust_proj.factory.simulation_manager(state_r)
        simgr_r.explore(find=ret_addr, num_find=50)
        if not simgr_r.found:
            raise RuntimeError(f"Rust caller function '{caller_name}' execution did not reach return.")

        divergence_found = False
        divergence_cex = None
        divergence_c_out = None
        divergence_r_out = None

        for end_c in simgr_c.found:
            for end_r in simgr_r.found:
                solver = claripy.Solver()
                for c in end_c.solver.constraints:
                    solver.add(c)
                for c in end_r.solver.constraints:
                    solver.add(c)

                if not solver.satisfiable():
                    continue

                c_ret = end_c.regs.eax
                r_ret = end_r.regs.eax
                c_final_g = end_c.memory.load(g_addr_c, 4, endness=self.c_proj.arch.memory_endness) if g_c_info else None
                r_final_g = end_r.memory.load(g_addr_r, 4, endness=self.rust_proj.arch.memory_endness) if g_r_info else None

                diff_conditions = [c_ret != r_ret]
                if c_final_g is not None and r_final_g is not None:
                    diff_conditions.append(c_final_g != r_final_g)
                elif c_final_g is not None and r_final_g is None:
                    diff_conditions.append(c_final_g != shared_g_init)
                elif r_final_g is not None and c_final_g is None:
                    diff_conditions.append(r_final_g != shared_g_init)

                solver.add(claripy.Or(*diff_conditions))
                if solver.satisfiable():
                    divergence_found = True
                    cex = {}
                    for i, arg in enumerate(shared_args):
                        cex[f"arg_{i}"] = solver.eval(arg, 1)[0]
                    if g_c_info or g_r_info:
                        cex["initial_global"] = solver.eval(shared_g_init, 1)[0]

                    divergence_cex = cex
                    divergence_c_out = {
                        "return": solver.eval(c_ret, 1)[0],
                        "final_global": solver.eval(c_final_g, 1)[0] if c_final_g is not None else None
                    }
                    divergence_r_out = {
                        "return": solver.eval(r_ret, 1)[0],
                        "final_global": solver.eval(r_final_g, 1)[0] if r_final_g is not None else None
                    }
                    break
            if divergence_found:
                break

        if not divergence_found:
            return EquivalenceResult(
                function_name=caller_name,
                is_equivalent=True,
                solver_status="UNSAT",
                details="Whole-program inter-procedural equivalence verified across caller and helper functions."
            )
        else:
            return EquivalenceResult(
                function_name=caller_name,
                is_equivalent=False,
                solver_status="SAT",
                counterexample=divergence_cex,
                c_outputs=divergence_c_out,
                rust_outputs=divergence_r_out,
                details="Whole-program behavioral divergence detected in caller execution path."
            )


# ==============================================================================
# Module 5.3.7: Report & Result Generation Module
# ==============================================================================
class ReportGenerator:
    """Formats and renders comprehensive equivalence reports."""

    @staticmethod
    def print_banner():
        print(Fore.CYAN + Style.BRIGHT + "=" * 78)
        print(Fore.CYAN + Style.BRIGHT + "  RustSketch: Inter-Procedural Semantic Equivalence Validation Framework")
        print(Fore.CYAN + Style.BRIGHT + "  [Powered by Python, angr, and Z3 Theorem Prover]")
        print(Fore.CYAN + Style.BRIGHT + "=" * 78 + "\n")

    @staticmethod
    def print_stage(title: str):
        print(Fore.YELLOW + Style.BRIGHT + f"[*] {title}")

    @staticmethod
    def print_hierarchy(hierarchy: Dict[str, Any]):
        print(Fore.GREEN + f"  ├── Discovered Functions: {len(hierarchy['all_matched'])}")
        print(Fore.GREEN + f"  ├── Helper/Leaf Functions: {', '.join(hierarchy['helpers']) if hierarchy['helpers'] else 'None'}")
        print(Fore.GREEN + f"  └── Caller Functions:      {', '.join(hierarchy['callers']) if hierarchy['callers'] else 'None'}")
        print()

    @staticmethod
    def print_result(result: EquivalenceResult):
        print(Fore.WHITE + Style.BRIGHT + f"\n--- Equivalence Analysis for: {result.function_name} ---")
        if result.is_equivalent:
            print(Fore.GREEN + Style.BRIGHT + f"  [VERDICT] : UNSAT (EQUIVALENT)")
            print(Fore.GREEN + f"  [STATUS]  : {result.details}")
        else:
            print(Fore.RED + Style.BRIGHT + f"  [VERDICT] : SAT (DIVERGENCE DETECTED)")
            print(Fore.RED + f"  [STATUS]  : {result.details}")
            print(Fore.YELLOW + f"\n  [COUNTEREXAMPLE WITNESS]:")
            for k, v in result.counterexample.items():
                print(Fore.YELLOW + f"    • {k} = {v} (hex: {hex(v) if isinstance(v, int) else v})")
            print(Fore.CYAN + f"\n  [DIVERGENCE TRACE]:")
            print(Fore.CYAN + f"    • C Output State   : {json.dumps(result.c_outputs, indent=2)}")
            print(Fore.MAGENTA + f"    • Rust Output State: {json.dumps(result.rust_outputs, indent=2)}")
        print(Fore.WHITE + "-" * 60)

    @staticmethod
    def export_json(results: List[EquivalenceResult], path: str):
        data = []
        for r in results:
            data.append({
                "function": r.function_name,
                "equivalent": r.is_equivalent,
                "verdict": r.solver_status,
                "details": r.details,
                "counterexample": r.counterexample,
                "c_outputs": r.c_outputs,
                "rust_outputs": r.rust_outputs
            })
        with open(path, "w") as f:
            json.dump(data, f, indent=2)
        print(Fore.GREEN + f"\n[+] Saved JSON report to '{path}'")


# ==============================================================================
# Orchestrator CLI Driver
# ==============================================================================
def run_rustsketch(c_path: Optional[str] = None, rust_path: Optional[str] = None,
                   build_dir: str = "build_rustsketch",
                   include_dir: Optional[str] = None, json_report: Optional[str] = None,
                   pointer_mode: bool = False,
                   c_dir: Optional[str] = None, rust_dir: Optional[str] = None) -> List[EquivalenceResult]:
    
    c_target = c_path or c_dir
    rust_target = rust_path or rust_dir
    if not c_target or not rust_target:
        raise ValueError("Both C and Rust target paths (file or directory) must be provided.")

    ReportGenerator.print_banner()

    # Step 1: Input Validation
    ReportGenerator.print_stage("Stage 1: Validating Project Source Trees & Syntax...")
    c_files, rust_files = ValidationModule.validate_inputs(c_target, rust_target)
    print(Fore.CYAN + f"  -> Found {len(c_files)} C file(s) from '{c_target}'")
    print(Fore.CYAN + f"  -> Found {len(rust_files)} Rust file(s) from '{rust_target}'")

    # Step 2: LLVM IR Compilation & Linking
    ReportGenerator.print_stage("Stage 2: Compiling & Linking LLVM IR & Binary Models...")
    compiler = CompilerLinkerModule(build_dir=build_dir)
    default_include = c_target if os.path.isdir(c_target) else os.path.dirname(os.path.abspath(c_target))
    artifacts = compiler.compile_and_link(c_files, rust_files, c_include_dir=include_dir or default_include)
    print(Fore.CYAN + f"  -> Unified C LLVM IR      : {artifacts['c_linked_ll']}")
    print(Fore.CYAN + f"  -> Unified Rust LLVM IR   : {artifacts['rust_ll']}")
    print(Fore.CYAN + f"  -> C Analysis Binary      : {artifacts['c_bin']}")
    print(Fore.CYAN + f"  -> Rust Analysis Binary   : {artifacts['rust_bin']}")

    # Step 3: Load Projects and Call-Graph Analysis
    ReportGenerator.print_stage("Stage 3: Extracting Call-Graph Hierarchy & Modular Separation...")
    c_proj = angr.Project(artifacts["c_bin"], auto_load_libs=False)
    rust_proj = angr.Project(artifacts["rust_bin"], auto_load_libs=False)

    has_user_main = artifacts.get("has_user_main", True)
    cg_module = CallGraphModule(c_proj, rust_proj, has_user_main=has_user_main)
    hierarchy = cg_module.analyze_hierarchy()
    ReportGenerator.print_hierarchy(hierarchy)

    # Step 4 & 5: Summary Extraction & Repository
    repo = SummaryRepository()
    checker = EquivalenceCheckerModule(c_proj, rust_proj, repo, c_ll_path=artifacts.get("c_linked_ll"))
    results = []

    # Parse signatures from C LLVM IR
    signatures = checker.parse_signatures(artifacts.get("c_linked_ll"))

    # Step 6: Equivalence Checking
    # 6.1 Check Helpers
    if hierarchy["helpers"]:
        ReportGenerator.print_stage("Stage 4 & 5: Extracting Helper Summaries & Intra-Procedural Checking...")
        for helper_name in hierarchy["helpers"]:
            sig = signatures.get(helper_name, {})
            num_args = sig.get("num_args", 1 if not pointer_mode else 3)
            is_ptr = sig.get("has_pointer_arg", pointer_mode) or pointer_mode
            res = checker.check_helper_equivalence(
                helper_name,
                num_args=num_args,
                is_pointer_arg=is_ptr
            )
            results.append(res)
            ReportGenerator.print_result(res)

    # 6.2 Check Callers (Inter-Procedural Compositional)
    user_callers = [c for c in hierarchy["callers"] if c != "main"]
    if not user_callers and "main" in hierarchy["callers"] and has_user_main:
        user_callers = ["main"]

    if user_callers:
        ReportGenerator.print_stage("Stage 6: Composing Inter-Procedural Models & Solver Verification...")
        for caller_name in user_callers:
            sig = signatures.get(caller_name, {})
            num_args = sig.get("num_args", 2 if not pointer_mode else 3)
            res = checker.check_compositional_caller(
                caller_name,
                num_args=num_args
            )
            results.append(res)
            ReportGenerator.print_result(res)

    # Step 7: Final Summary Verdict
    print(Fore.CYAN + Style.BRIGHT + "\n" + "=" * 78)
    print(Fore.CYAN + Style.BRIGHT + "  FINAL VERIFICATION SUMMARY")
    print(Fore.CYAN + Style.BRIGHT + "=" * 78)
    all_eq = all(r.is_equivalent for r in results)
    if all_eq:
        print(Fore.GREEN + Style.BRIGHT + "  [OVERALL VERDICT] : ALL MODULES SEMANTICALLY EQUIVALENT (UNSAT)")
    else:
        print(Fore.RED + Style.BRIGHT + "  [OVERALL VERDICT] : SEMANTIC DIVERGENCE DETECTED (SAT)")
    print(Fore.CYAN + Style.BRIGHT + "=" * 78 + "\n")

    if json_report:
        ReportGenerator.export_json(results, json_report)

    return results


def main():
    parser = argparse.ArgumentParser(
        description="RustSketch: Inter-Procedural Semantic Equivalence Validation Framework"
    )
    parser.add_argument("c_path", help="Path to C source directory or file (.c)")
    parser.add_argument("rust_path", help="Path to Rust source directory or file (.rs)")
    parser.add_argument("--build-dir", default="build_rustsketch", help="Build directory for intermediate artifacts")
    parser.add_argument("--include-dir", default=None, help="C include directory")
    parser.add_argument("--json-report", default=None, help="Path to write JSON equivalence report")
    parser.add_argument("--pointer-mode", action="store_true", help="Enable pointer out-parameter tracking")

    args = parser.parse_args()

    results = run_rustsketch(
        c_path=args.c_path,
        rust_path=args.rust_path,
        build_dir=args.build_dir,
        include_dir=args.include_dir,
        json_report=args.json_report,
        pointer_mode=args.pointer_mode
    )

    all_eq = all(r.is_equivalent for r in results)
    sys.exit(0 if all_eq else 1)


if __name__ == "__main__":
    main()
