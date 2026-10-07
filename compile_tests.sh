#!/usr/bin/env bash
# ==============================================================================
# compile_tests.sh: Automated LLVM IR Compilation for RustSketch Benchmark Suite
# Compiles C files to LLVM IR (clang -S -emit-llvm)
# Compiles Rust files to LLVM IR (rustc -C overflow-checks=off -C panic=abort --emit=llvm-ir)
# ==============================================================================

set -e

BASE_DIR="${1:-tests2}"

if [ ! -d "$BASE_DIR" ]; then
    if [ -d "tests" ]; then
        BASE_DIR="tests"
    else
        echo "Error: Directory '$BASE_DIR' not found."
        exit 1
    fi
fi

echo "=============================================================================="
echo "  RustSketch Automated LLVM IR Test Compiler"
echo "  Target Directory: ${BASE_DIR}"
echo "=============================================================================="

TOTAL_COMPILED=0
FAILURES=0

for dir in "$BASE_DIR"/*/; do
    [ -d "$dir" ] || continue
    subname=$(basename "$dir")
    
    # Skip fixtures directory or cache if inside tests
    if [ "$subname" = "fixtures" ] || [ "$subname" = "__pycache__" ]; then
        continue
    fi

    echo -e "\n[*] Processing Scenario: ${subname} ($dir)"

    # 1. Compile C to LLVM IR
    if [ -f "${dir}test.c" ]; then
        echo "    -> Compiling C: ${dir}test.c -> ${dir}test.ll"
        if clang -S -emit-llvm -O0 -g -fno-discard-value-names "${dir}test.c" -o "${dir}test.ll"; then
            TOTAL_COMPILED=$((TOTAL_COMPILED + 1))
        else
            echo "    [ERROR] Failed to compile ${dir}test.c"
            FAILURES=$((FAILURES + 1))
        fi
    fi

    # 2. Compile Correct Rust to LLVM IR
    if [ -f "${dir}test_correct.rs" ]; then
        echo "    -> Compiling Rust (Correct): ${dir}test_correct.rs -> ${dir}test_correct.ll"
        if rustc -C overflow-checks=off -C panic=abort -C opt-level=0 -g --emit=llvm-ir "${dir}test_correct.rs" -o "${dir}test_correct.ll"; then
            TOTAL_COMPILED=$((TOTAL_COMPILED + 1))
        else
            echo "    [ERROR] Failed to compile ${dir}test_correct.rs"
            FAILURES=$((FAILURES + 1))
        fi
    fi

    # 3. Compile Buggy Rust to LLVM IR
    if [ -f "${dir}test_buggy.rs" ]; then
        echo "    -> Compiling Rust (Buggy): ${dir}test_buggy.rs -> ${dir}test_buggy.ll"
        if rustc -C overflow-checks=off -C panic=abort -C opt-level=0 -g --emit=llvm-ir "${dir}test_buggy.rs" -o "${dir}test_buggy.ll"; then
            TOTAL_COMPILED=$((TOTAL_COMPILED + 1))
        else
            echo "    [ERROR] Failed to compile ${dir}test_buggy.rs"
            FAILURES=$((FAILURES + 1))
        fi
    fi
done

echo ""
echo "=============================================================================="
echo "  COMPILATION SUMMARY"
echo "  Total LLVM IR modules emitted: ${TOTAL_COMPILED}"
echo "  Failures: ${FAILURES}"
echo "=============================================================================="

if [ $FAILURES -eq 0 ]; then
    exit 0
else
    exit 1
fi
