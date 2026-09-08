#!/usr/bin/env bash
set -e

# ==============================================================================
# RustSketch: Environment Setup & Validation Script
# ==============================================================================

echo "========================================================"
echo "          RustSketch Environment Setup & Validation     "
echo "========================================================"

# 1. Verify / Install OS & Build Packages
echo "[1/4] Checking system build tools and LLVM toolchain..."

MISSING_PACKAGES=()
for pkg in clang llvm llvm-link make gcc python3 python3-venv python3-pip; do
    if ! command -v "$pkg" &> /dev/null; then
        # Check if llvm-link specifically is installed via llvm
        if [ "$pkg" = "llvm-link" ] && command -v llvm-link-18 &> /dev/null; then
            continue
        fi
        MISSING_PACKAGES+=("$pkg")
    fi
done

if [ ${#MISSING_PACKAGES[@]} -ne 0 ]; then
    echo "  -> Missing system packages detected: ${MISSING_PACKAGES[*]}"
    echo "  -> Attempting apt installation (may require sudo privileges)..."
    if [ "$(id -u)" -eq 0 ]; then
        apt-get update && apt-get install -y build-essential clang llvm python3 python3-venv python3-pip
    else
        sudo apt-get update && sudo apt-get install -y build-essential clang llvm python3 python3-venv python3-pip
    fi
else
    echo "  -> System build packages and LLVM tools are present."
fi

# Print versions
echo "  -> Clang version: $(clang --version | head -n 1)"
echo "  -> LLVM-Link version: $(llvm-link --version | head -n 2 | tail -n 1)"

# 2. Check Rust Toolchain
echo "[2/4] Checking Rust toolchain (rustc)..."
if ! command -v rustc &> /dev/null; then
    if [ -f "$HOME/.cargo/env" ]; then
        source "$HOME/.cargo/env"
    fi
fi

if ! command -v rustc &> /dev/null; then
    echo "  -> rustc not found. Installing Rust via rustup..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
else
    echo "  -> Rust toolchain found: $(rustc --version)"
fi

# 3. Python Virtual Environment Setup
VENV_DIR="angr_env"
echo "[3/4] Setting up Python virtual environment in '$VENV_DIR'..."

if [ ! -d "$VENV_DIR" ]; then
    python3 -m venv "$VENV_DIR"
    echo "  -> Created virtual environment '$VENV_DIR'."
else
    echo "  -> Existing virtual environment '$VENV_DIR' found."
fi

# Activate venv
source "$VENV_DIR/bin/activate"

# 4. Install Python Dependencies
echo "[4/4] Installing / Upgrading Python dependencies (angr, z3-solver, claripy)..."
pip install --upgrade pip setuptools wheel
pip install -r requirements.txt

# Validation check
python3 -c "
import angr
import z3
import claripy
print(f'  -> angr version: {angr.__version__}')
print(f'  -> z3 version: {z3.get_version_string()}')
print(f'  -> claripy loaded successfully')
"

echo "========================================================"
echo "  RustSketch environment is fully configured and ready! "
echo "  Activate with: source $VENV_DIR/bin/activate         "
echo "========================================================"
