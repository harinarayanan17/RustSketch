#!/usr/bin/env python3
"""
run_large_benchmarks.py: Automated Large Benchmark Verification Runner
Executes RustSketch on full-featured large programs (cryptographic hashing,
circular ringbuffer packet parser, 3D affine matrix transformations, multi-file banking).
"""

import os
import sys
import time
import json

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from rustsketch import run_rustsketch

BENCHMARKS = [
    {
        "id": "01_hash_pipeline",
        "title": "FNV-1a & Murmur Avalanche Hash Pipeline (5 functions)",
        "c_path": "large_benchmarks/01_hash_pipeline/test.c",
        "correct_path": "large_benchmarks/01_hash_pipeline/test_correct.rs",
        "buggy_path": "large_benchmarks/01_hash_pipeline/test_buggy.rs",
        "num_functions": 5
    },
    {
        "id": "02_packet_ringbuffer",
        "title": "Circular Ring Buffer & Packet Header Protocol (4 functions)",
        "c_path": "large_benchmarks/02_packet_ringbuffer/test.c",
        "correct_path": "large_benchmarks/02_packet_ringbuffer/test_correct.rs",
        "buggy_path": "large_benchmarks/02_packet_ringbuffer/test_buggy.rs",
        "num_functions": 4
    },
    {
        "id": "03_matrix_transform",
        "title": "3D Vector & Affine Matrix Transformation Engine (5 functions)",
        "c_path": "large_benchmarks/03_matrix_transform/test.c",
        "correct_path": "large_benchmarks/03_matrix_transform/test_correct.rs",
        "buggy_path": "large_benchmarks/03_matrix_transform/test_buggy.rs",
        "num_functions": 5
    },
    {
        "id": "04_multi_file_banking",
        "title": "Multi-File Modular Banking Project (helper.c, main.c / helper.rs, main.rs)",
        "c_path": "/home/hari/test/c_project",
        "correct_path": "/home/hari/test/rust_project",
        "buggy_path": None,
        "num_functions": 3
    }
]

def main():
    results = []
    print("=" * 80)
    print("  RUSTSKETCH LARGE PROGRAM VERIFICATION BENCHMARK SUITE")
    print("=" * 80)

    for b in BENCHMARKS:
        print(f"\n>>> Running Benchmark: {b['title']}")

        # 1. Correct Translation
        t0 = time.time()
        res_correct = run_rustsketch(b["c_path"], b["correct_path"], build_dir=f"build_rustsketch/{b['id']}_c")
        correct_passed = all(r.is_equivalent for r in res_correct)
        t_correct = round(time.time() - t0, 2)
        print(f"    [Correct] Verdict: {'UNSAT (Equivalent)' if correct_passed else 'SAT'} in {t_correct}s")

        # 2. Buggy Translation (if applicable)
        if b["buggy_path"]:
            t0 = time.time()
            res_buggy = run_rustsketch(b["c_path"], b["buggy_path"], build_dir=f"build_rustsketch/{b['id']}_b")
            buggy_caught = any(not r.is_equivalent for r in res_buggy)
            t_buggy = round(time.time() - t0, 2)
            print(f"    [Buggy]   Verdict: {'SAT (Divergence Caught)' if buggy_caught else 'UNSAT'} in {t_buggy}s")
        else:
            buggy_caught = None
            t_buggy = None

        results.append({
            "id": b["id"],
            "title": b["title"],
            "functions": b["num_functions"],
            "correct_verdict": "UNSAT" if correct_passed else "SAT",
            "correct_time": t_correct,
            "correct_passed": correct_passed,
            "buggy_verdict": "SAT" if buggy_caught else ("N/A" if buggy_caught is None else "UNSAT"),
            "buggy_time": t_buggy,
            "buggy_passed": buggy_caught
        })

    with open("large_benchmark_results.json", "w") as f:
        json.dump(results, f, indent=2)

    print("\n" + "=" * 80)
    print("  LARGE BENCHMARK SUITE COMPLETED SUCCESSFULLY")
    print("=" * 80)

if __name__ == "__main__":
    main()
