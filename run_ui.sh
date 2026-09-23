#!/usr/bin/env bash
# ==============================================================================
# RustSketch: Vintage Coding UI Launcher
# Starts the FastAPI Verification Bridge & the React Vintage Frontend
# ==============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo -e "\033[1;36m==============================================================================\033[0m"
echo -e "\033[1;36m  RustSketch: Semantic Equivalence Validation Framework [VINTAGE UI]\033[0m"
echo -e "\033[1;36m==============================================================================\033[0m"

# Ensure virtualenv exists
if [ ! -d "angr_env" ]; then
    echo -e "\033[1;31m[-] angr_env not found. Please run ./setup.sh first.\033[0m"
    exit 1
fi

PYTHON_EXEC="$SCRIPT_DIR/angr_env/bin/python3"

# Ensure server dependencies are installed
"$PYTHON_EXEC" -c "import fastapi, uvicorn" 2>/dev/null || {
    echo -e "\033[1;33m[*] Installing web server dependencies (fastapi, uvicorn)...\033[0m"
    "$SCRIPT_DIR/angr_env/bin/pip" install fastapi uvicorn
}

# Check if production build exists, rebuild if missing
if [ ! -d "ui/dist" ]; then
    echo -e "\033[1;33m[*] Building frontend assets...\033[0m"
    (cd ui && npm install && npm run build)
fi

echo -e "\033[1;32m[+] Starting RustSketch Backend API on http://localhost:8000\033[0m"
"$PYTHON_EXEC" server.py &
SERVER_PID=$!

trap "kill $SERVER_PID 2>/dev/null || true; exit" SIGINT SIGTERM EXIT

sleep 2

# Check if user wants Vite Dev server or standalone
if [ "$1" == "--dev" ]; then
    echo -e "\033[1;32m[+] Launching Vite Dev Server on http://localhost:5173\033[0m"
    (cd ui && npm run dev)
else
    echo -e "\033[1;32m[+] RustSketch Vintage UI is now online at: \033[1;33mhttp://localhost:8000\033[0m"
    echo -e "\033[1;36m[i] Press Ctrl+C to terminate the server.\033[0m"
    wait $SERVER_PID
fi
