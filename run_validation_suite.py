#!/usr/bin/env python3
"""
run_validation_suite.py: Automated Validation Runner for RustSketch Test Suite
Executes rustsketch against all 10 scenarios (correct vs buggy) and computes
pipeline accuracy, True Positives (SAT on buggy), and True Negatives (UNSAT on correct).
"""

import os
import sys
import json
import time

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from rustsketch import run_rustsketch

SCENARIOS = [
    ("global_state", "1. Global State Trap"),
    ("out_param", "2. Single Out Parameter"),
    ("algebraic", "3. Algebraic Equivalence"),
    ("aliasing", "4. Multi-Pointer Aliasing"),
    ("double_pointer", "5. Multi-Level Indirection (**p)"),
    ("memory_layout", "6. Structs & Unions"),
    ("composition", "7. Call-Graph Composition"),
    ("void_return", "8. Return Type Adaptation (void)"),
    ("mixed_complex", "9. Mixed Complex Scenarios"),
    ("interface_conformity", "10. Interface & Name Conformity")
]

def run_suite(base_dir="tests2"):
    results = []
    print("=" * 80)
    print(f"  RUNNING RUSTSKETCH AUTOMATED VALIDATION SUITE ON: {base_dir}")
    print("=" * 80)

    for slug, label in SCENARIOS:
        dir_path = os.path.join(base_dir, slug)
        c_file = os.path.join(dir_path, "test.c")
        correct_file = os.path.join(dir_path, "test_correct.rs")
        buggy_file = os.path.join(dir_path, "test_buggy.rs")

        # 1. Test Correct Translation (Expect UNSAT)
        print(f"\n[*] Evaluating [{label}] - Correct Translation...")
        start_t = time.time()
        try:
            res_correct = run_rustsketch(c_file, correct_file, build_dir=f"build_rustsketch/{slug}_correct")
            all_eq = all(r.is_equivalent for r in res_correct)
            verdict_correct = "UNSAT (Equivalent)" if all_eq else "SAT (Divergent)"
            correct_ok = all_eq
        except Exception as e:
            verdict_correct = f"ERROR: {e}"
            correct_ok = False
        time_correct = round(time.time() - start_t, 2)

        # 2. Test Buggy Translation (Expect SAT)
        print(f"\n[*] Evaluating [{label}] - Buggy Translation...")
        start_t = time.time()
        try:
            res_buggy = run_rustsketch(c_file, buggy_file, build_dir=f"build_rustsketch/{slug}_buggy")
            all_eq_buggy = all(r.is_equivalent for r in res_buggy)
            verdict_buggy = "SAT (Divergent)" if not all_eq_buggy else "UNSAT (Equivalent)"
            buggy_ok = not all_eq_buggy
        except Exception as e:
            verdict_buggy = f"ERROR: {e}"
            buggy_ok = False
        time_buggy = round(time.time() - start_t, 2)

        results.append({
            "scenario": label,
            "slug": slug,
            "correct": {
                "expected": "UNSAT (Equivalent)",
                "actual": verdict_correct,
                "passed": correct_ok,
                "time": time_correct
            },
            "buggy": {
                "expected": "SAT (Divergent)",
                "actual": verdict_buggy,
                "passed": buggy_ok,
                "time": time_buggy
            }
        })

    # Summary
    tp = sum(1 for r in results if r["buggy"]["passed"])
    tn = sum(1 for r in results if r["correct"]["passed"])
    fp = sum(1 for r in results if not r["correct"]["passed"])
    fn = sum(1 for r in results if not r["buggy"]["passed"])
    total = len(results) * 2
    passed_total = tp + tn

    print("\n" + "=" * 80)
    print("  VALIDATION SUITE COMPLETE")
    print(f"  True Positives (Bugs Caught / SAT)   : {tp}/{len(results)}")
    print(f"  True Negatives (Correct Proven / UNSAT): {tn}/{len(results)}")
    print(f"  Total Accuracy                       : {passed_total}/{total} ({passed_total/total*100:.1f}%)")
    print("=" * 80)

    with open("validation_results.json", "w") as f:
        json.dump({
            "results": results,
            "metrics": {
                "true_positives": tp,
                "true_negatives": tn,
                "false_positives": fp,
                "false_negatives": fn,
                "accuracy": passed_total / total
            }
        }, f, indent=2)

    return results

if __name__ == "__main__":
    base = sys.argv[1] if len(sys.argv) > 1 else "tests2"
    run_suite(base)
