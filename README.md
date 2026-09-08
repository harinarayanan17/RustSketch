# RustSketch

**Inter-Procedural Semantic Equivalence Validation Framework for C-to-Rust Transpilation**

[![Python 3.10+](https://img.shields.io/badge/Python-3.10+-blue.svg)](https://www.python.org/)
[![LLVM](https://img.shields.io/badge/LLVM-Clang%20%2F%20llvm--link-orange.svg)](https://llvm.org/)
[![Z3](https://img.shields.io/badge/SMT%20Solver-Z3-green.svg)](https://github.com/Z3Prover/z3)
[![angr](https://img.shields.io/badge/Symbolic%20Execution-angr-red.svg)](https://angr.io/)

---

## 📌 Overview

**RustSketch** is a formal verification framework engineered to validate semantic equivalence between original C programs and their transpiled Rust counterparts. 

Transpiling legacy C to Rust often introduces subtle behavioral divergences—such as unhandled global state side-effects, integer overflow disparities, and mutated pointer out-parameters. **RustSketch** decomposes multi-file C and Rust codebases, lifts them to language-agnostic LLVM IR representations, symbolically executes functions using `angr`, generates mathematical pre/post-condition summaries, and leverages the **Z3 SMT Solver** to formally prove equivalence (`UNSAT`) or synthesize concrete divergence counter-examples (`SAT`).

---

## 🏗️ Architecture & Pipeline

```
 ┌─────────────────┐       ┌─────────────────┐
 │   C Source(s)   │       │  Rust Source(s) │
 └────────┬────────┘       └────────┬────────┘
          │ (clang -emit-llvm)      │ (rustc --emit=llvm-ir,obj)
          ▼                         ▼
 ┌─────────────────┐       ┌─────────────────┐
 │ C LLVM IR (.ll) │       │ Rust LLVM IR(.ll)
 └────────┬────────┘       └────────┬────────┘
          │ (llvm-link)             │
          ▼                         ▼
   Linked C Module            Instrumented Rust Module
          │                         │
          └────────────┬────────────┘
                       │
                       ▼
 ┌───────────────────────────────────────────────┐
 │ Call-Graph & Function Separation Module       │
 │ - Identifies Leaf/Helper functions vs Callers │
 └─────────────────────┬─────────────────────────┘
                       │
                       ▼
 ┌───────────────────────────────────────────────┐
 │ Symbolic Execution & Summary Generation (angr)│
 │ - Computes symbolic return expressions        │
 │ - Tracks global memory mutation side-effects  │
 │ - Tracks pointer out-parameter updates        │
 └─────────────────────┬─────────────────────────┘
                       │
                       ▼
 ┌───────────────────────────────────────────────┐
 │ Z3 SMT Solver & Equivalence Verification      │
 │ - Difference Query: Summary_C != Summary_Rust │
 └─────────────────────┬─────────────────────────┘
                       │
        ┌──────────────┴──────────────┐
        ▼                             ▼
  [UNSAT Verdict]               [SAT Verdict]
  Semantically Equivalent     Divergence Counter-Example
```

### Core Modules

1. **Validation Module (`5.3.1`)**: Inspects input paths, verifies file structures, and discovers compilation targets across single files or multi-file project trees.
2. **LLVM IR Compilation & Linking Module (`5.3.2`)**: Compiles C files into bitcode via `clang`, links them using `llvm-link`, instruments Rust code (`#[no_mangle]`, `pub static mut` exports), and builds relocatable binary models.
3. **Call-Graph Analysis & Separation Module (`5.3.3`)**: Parses LLVM call graphs to separate independent helper/leaf functions from composed caller functions.
4. **Symbolic Execution Module (`5.3.4`)**: Employs `angr` to symbolically explore execution paths, formulating symbolic constraints for both return values and memory side-effects.
5. **Summary Repository (`5.3.5`)**: Stores mathematical post-condition summaries (return values, global state mutations, pointer mutations).
6. **Z3 SMT Solver Module (`5.3.6`)**: Formulates differential queries `(Summary_C ≠ Summary_Rust)` to mathematically check for equivalence across all inputs.
7. **Reporting & Counter-Example Generator (`5.3.7`)**: Displays colored terminal reports, formats counter-example inputs/outputs, and exports JSON audit reports.

---

## 🚀 Installation & Prerequisites

### System Requirements
- **Linux** (Ubuntu 22.04+ recommended)
- **Clang & LLVM Toolchain** (`clang`, `llvm-link`, `llvm`)
- **Rust Toolchain** (`rustc`, `cargo`)
- **Python 3.10+**

### Automated Setup

Run the automated setup script to install dependencies, verify tools, create a Python virtual environment, and install required packages:

```bash
chmod +x setup.sh
./setup.sh
```

Activate the virtual environment:
```bash
source angr_env/bin/activate
```

---

## 💻 CLI Usage

```bash
python3 rustsketch.py <c_path> <rust_path> [options]
```

### Arguments & Flags

| Flag | Description | Default |
|------|-------------|---------|
| `c_path` | Path to C source file (`.c`) or project directory | *Required* |
| `rust_path` | Path to Rust source file (`.rs`) or project directory | *Required* |
| `--pointer-mode` | Enable tracking of pointer out-parameter mutations | `False` |
| `--include-dir` | Path to additional C header include directory | `None` |
| `--build-dir` | Output directory for intermediate LLVM bitcode and binaries | `build_rustsketch` |
| `--json-report` | Export formal verification findings to a JSON file | `None` |

---

## 📖 Examples

### 1. Verifying Single Files

```bash
python3 rustsketch.py tests/fixtures/01_global_state_divergence/c/main.c \
                     tests/fixtures/01_global_state_divergence/rust_fixed/src/main.rs
```

### 2. Multi-File Projects with Global State Side-Effects

```bash
python3 rustsketch.py tests/fixtures/01_global_state_divergence/c \
                     tests/fixtures/01_global_state_divergence/rust_fixed/src \
                     --json-report divergence_report.json
```

**Output:**
```text
==============================================================================
  FINAL VERIFICATION SUMMARY
==============================================================================
  [OVERALL VERDICT] : ALL MODULES SEMANTICALLY EQUIVALENT (UNSAT)
==============================================================================
```

### 3. Detecting Divergence & Counter-Examples

When verifying a buggy Rust transpilation:
```bash
python3 rustsketch.py tests/fixtures/01_global_state_divergence/c \
                     tests/fixtures/01_global_state_divergence/rust_buggy/src
```

**Output:**
```text
[-] Function 'caller_step': DIVERGENCE DETECTED (SAT)
    Discrepancy Details:
      * Global State 'g_counter' Divergence:
        - C State:    (initial_counter + x)
        - Rust State: (initial_counter + 2*x)
    Counter-Example Input:
      arg_0 = 0x1, g_counter = 0x0
```

### 4. Pointer Out-Parameter Tracking (`--pointer-mode`)

```bash
python3 rustsketch.py tests/fixtures/02_pointer_outparam/c \
                     tests/fixtures/02_pointer_outparam/rust_fixed/src \
                     --pointer-mode
```

---

## 🧪 Running the Test Suite

Run unit tests and verification fixture benchmarks using `pytest`:

```bash
pytest tests/ -v
```

---

## 📄 License

This project is licensed under the MIT License.
