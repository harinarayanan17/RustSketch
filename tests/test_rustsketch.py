import os
import sys
import pytest

# Ensure rustsketch is importable
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from rustsketch import (
    ValidationModule,
    CompilerLinkerModule,
    CallGraphModule,
    run_rustsketch,
)


def test_input_validation():
    c_files, rust_files = ValidationModule.validate_inputs(
        "tests/fixtures/01_global_state_divergence/c",
        "tests/fixtures/01_global_state_divergence/rust_fixed/src"
    )
    assert len(c_files) >= 2
    assert len(rust_files) >= 1


def test_input_validation_single_files():
    c_files, rust_files = ValidationModule.validate_inputs(
        "tests/fixtures/02_pointer_outparam/c/main.c",
        "tests/fixtures/02_pointer_outparam/rust_fixed/src/main.rs"
    )
    assert len(c_files) == 1
    assert os.path.basename(c_files[0]) == "main.c"
    assert len(rust_files) == 1
    assert os.path.basename(rust_files[0]) == "main.rs"


def test_single_file_run(tmp_path):
    c_file = tmp_path / "single.c"
    rust_file = tmp_path / "single.rs"
    build_dir = str(tmp_path / "build_single")

    c_file.write_text("""
int helper_calc(int x) {
    return x * 3;
}

int caller_calc(int a, int b) {
    return helper_calc(a) + b;
}

int main() {
    return caller_calc(1, 2);
}
""")

    rust_file.write_text("""
#[no_mangle]
pub extern "C" fn helper_calc(x: i32) -> i32 {
    x * 3
}

#[no_mangle]
pub extern "C" fn caller_calc(a: i32, b: i32) -> i32 {
    helper_calc(a) + b
}

fn main() {
    let res = caller_calc(1, 2);
    std::process::exit(res);
}
""")

    results = run_rustsketch(
        c_path=str(c_file),
        rust_path=str(rust_file),
        build_dir=build_dir
    )
    assert len(results) >= 1
    assert all(r.is_equivalent for r in results)


def test_compilation_and_linking(tmp_path):
    build_dir = str(tmp_path / "build_test")
    compiler = CompilerLinkerModule(build_dir=build_dir)
    c_files = [
        "tests/fixtures/01_global_state_divergence/c/helper.c",
        "tests/fixtures/01_global_state_divergence/c/main.c"
    ]
    rust_files = [
        "tests/fixtures/01_global_state_divergence/rust_fixed/src/main.rs"
    ]
    artifacts = compiler.compile_and_link(
        c_files, rust_files,
        c_include_dir="tests/fixtures/01_global_state_divergence/c"
    )
    assert os.path.exists(artifacts["c_linked_ll"])
    assert os.path.exists(artifacts["rust_ll"])
    assert os.path.exists(artifacts["c_bin"])
    assert os.path.exists(artifacts["rust_bin"])


def test_fixture01_global_state_buggy_divergence(tmp_path):
    build_dir = str(tmp_path / "build_f1_buggy")
    results = run_rustsketch(
        c_dir="tests/fixtures/01_global_state_divergence/c",
        rust_dir="tests/fixtures/01_global_state_divergence/rust_buggy/src",
        build_dir=build_dir
    )
    assert len(results) >= 1
    # Should detect divergence
    all_eq = all(r.is_equivalent for r in results)
    assert all_eq is False
    buggy_res = next(r for r in results if not r.is_equivalent)
    assert buggy_res.solver_status == "SAT"
    assert buggy_res.counterexample is not None


def test_fixture01_global_state_fixed_equivalence(tmp_path):
    build_dir = str(tmp_path / "build_f1_fixed")
    results = run_rustsketch(
        c_dir="tests/fixtures/01_global_state_divergence/c",
        rust_dir="tests/fixtures/01_global_state_divergence/rust_fixed/src",
        build_dir=build_dir
    )
    assert len(results) >= 1
    all_eq = all(r.is_equivalent for r in results)
    assert all_eq is True
    for r in results:
        assert r.solver_status == "UNSAT"


def test_fixture02_pointer_outparam_buggy_divergence(tmp_path):
    build_dir = str(tmp_path / "build_f2_buggy")
    results = run_rustsketch(
        c_dir="tests/fixtures/02_pointer_outparam/c",
        rust_dir="tests/fixtures/02_pointer_outparam/rust_buggy/src",
        build_dir=build_dir,
        pointer_mode=True
    )
    assert len(results) >= 1
    all_eq = all(r.is_equivalent for r in results)
    assert all_eq is False
    caller_res = next(r for r in results if r.function_name == "caller_transform")
    assert caller_res.solver_status == "SAT"


def test_fixture02_pointer_outparam_fixed_equivalence(tmp_path):
    build_dir = str(tmp_path / "build_f2_fixed")
    results = run_rustsketch(
        c_dir="tests/fixtures/02_pointer_outparam/c",
        rust_dir="tests/fixtures/02_pointer_outparam/rust_fixed/src",
        build_dir=build_dir,
        pointer_mode=True
    )
    assert len(results) >= 1
    all_eq = all(r.is_equivalent for r in results)
    assert all_eq is True
    for r in results:
        assert r.solver_status == "UNSAT"


def test_c_rust_multi_file_project_equivalence(tmp_path):
    if not (os.path.exists("/home/hari/test/c_project") and os.path.exists("/home/hari/test/rust_project")):
        pytest.skip("Test fixtures in /home/hari/test not found")
    build_dir = str(tmp_path / "build_multi_test")
    results = run_rustsketch(
        c_path="/home/hari/test/c_project",
        rust_path="/home/hari/test/rust_project",
        build_dir=build_dir
    )
    assert len(results) >= 1
    assert all(r.is_equivalent for r in results)
    for r in results:
        assert r.solver_status == "UNSAT"

