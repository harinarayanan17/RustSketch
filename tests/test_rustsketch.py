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


def test_fixture02_pointer_outparam_auto_detection(tmp_path):
    # Test auto-detection on fixed implementation (pointer_mode omitted / None)
    build_dir_fixed = str(tmp_path / "build_f2_auto_fixed")
    results_fixed = run_rustsketch(
        c_dir="tests/fixtures/02_pointer_outparam/c",
        rust_dir="tests/fixtures/02_pointer_outparam/rust_fixed/src",
        build_dir=build_dir_fixed
    )
    assert len(results_fixed) >= 1
    assert all(r.is_equivalent for r in results_fixed) is True
    for r in results_fixed:
        assert r.solver_status == "UNSAT"

    # Test auto-detection on buggy implementation (pointer_mode omitted / None)
    build_dir_buggy = str(tmp_path / "build_f2_auto_buggy")
    results_buggy = run_rustsketch(
        c_dir="tests/fixtures/02_pointer_outparam/c",
        rust_dir="tests/fixtures/02_pointer_outparam/rust_buggy/src",
        build_dir=build_dir_buggy
    )
    assert len(results_buggy) >= 1
    assert all(r.is_equivalent for r in results_buggy) is False
    buggy_caller = next(r for r in results_buggy if r.function_name == "caller_transform")
    assert buggy_caller.solver_status == "SAT"

    # Test server pre-scan helper
    from server import detect_c_pointers
    assert detect_c_pointers("void transform_ptr(int *ptr, int scale, int offset) { *ptr = scale; }") is True
    assert detect_c_pointers("int add(int a, int b) { return a + b; }") is False
    assert detect_c_pointers("int main(int argc, char **argv) { return 0; }") is False



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


def test_fact_loop_equivalence(tmp_path):
    if not (os.path.exists("/home/hari/test/fact.c") and os.path.exists("/home/hari/test/fact_rust.rs")):
        pytest.skip("Factorial fixtures not found")
    build_dir = str(tmp_path / "build_fact_test")
    results = run_rustsketch(
        c_path="/home/hari/test/fact.c",
        rust_path="/home/hari/test/fact_rust.rs",
        build_dir=build_dir
    )
    assert len(results) >= 1
    assert all(r.is_equivalent for r in results)
    for r in results:
        assert r.solver_status == "UNSAT"


def test_point_struct_equivalence(tmp_path):
    if not (os.path.exists("/home/hari/test/point.c") and os.path.exists("/home/hari/test/point_rust.rs")):
        pytest.skip("Point fixtures not found")
    build_dir = str(tmp_path / "build_point_test")
    results = run_rustsketch(
        c_path="/home/hari/test/point.c",
        rust_path="/home/hari/test/point_rust.rs",
        build_dir=build_dir
    )
    assert len(results) >= 1
    assert all(r.is_equivalent for r in results)
    for r in results:
        assert r.solver_status == "UNSAT"


def test_pattern1_aliased_parameters_equivalence(tmp_path):
    c_file = tmp_path / "p1.c"
    rust_fixed = tmp_path / "p1_fixed.rs"
    rust_buggy = tmp_path / "p1_buggy.rs"

    c_file.write_text("""
void update(int *a, int *b) {
    *a = 10;
    *b = 20;
}

int caller_baz(void) {
    int x = 1;
    update(&x, &x);
    return x;
}

int main() {
    return caller_baz();
}
""")

    rust_fixed.write_text("""
#[no_mangle]
pub unsafe extern "C" fn update(a: *mut i32, b: *mut i32) {
    *a = 10;
    *b = 20;
}

#[no_mangle]
pub extern "C" fn caller_baz() -> i32 {
    let mut x = 1;
    unsafe {
        update(&mut x as *mut i32, &mut x as *mut i32);
    }
    x
}

fn main() {
    let res = caller_baz();
    std::process::exit(res);
}
""")

    rust_buggy.write_text("""
#[no_mangle]
pub unsafe extern "C" fn update(a: *mut i32, b: *mut i32) {
    *a = 10;
}

#[no_mangle]
pub extern "C" fn caller_baz() -> i32 {
    let mut x = 1;
    unsafe {
        update(&mut x as *mut i32, &mut x as *mut i32);
    }
    x
}

fn main() {
    let res = caller_baz();
    std::process::exit(res);
}
""")

    res_fixed = run_rustsketch(
        c_path=str(c_file),
        rust_path=str(rust_fixed),
        build_dir=str(tmp_path / "build_p1_fixed")
    )
    assert len(res_fixed) >= 1
    assert all(r.is_equivalent for r in res_fixed)

    res_buggy = run_rustsketch(
        c_path=str(c_file),
        rust_path=str(rust_buggy),
        build_dir=str(tmp_path / "build_p1_buggy")
    )
    assert any(not r.is_equivalent for r in res_buggy)


def test_pattern2_double_pointer_nullify_equivalence(tmp_path):
    c_file = tmp_path / "p2.c"
    rust_fixed = tmp_path / "p2_fixed.rs"

    c_file.write_text("""
void nullify_ptr(int **p) {
    *p = 0;
}

int caller_nullify(void) {
    int target = 42;
    int *p = &target;
    nullify_ptr(&p);
    return (p == 0) ? 1 : 0;
}

int main() {
    return caller_nullify();
}
""")

    rust_fixed.write_text("""
#[no_mangle]
pub unsafe extern "C" fn nullify_ptr(p: *mut *mut i32) {
    *p = std::ptr::null_mut();
}

#[no_mangle]
pub extern "C" fn caller_nullify() -> i32 {
    let mut target = 42;
    let mut p = &mut target as *mut i32;
    unsafe {
        nullify_ptr(&mut p as *mut *mut i32);
    }
    if p.is_null() { 1 } else { 0 }
}

fn main() {
    let res = caller_nullify();
    std::process::exit(res);
}
""")

    res_fixed = run_rustsketch(
        c_path=str(c_file),
        rust_path=str(rust_fixed),
        build_dir=str(tmp_path / "build_p2_fixed")
    )
    assert len(res_fixed) >= 1
    assert all(r.is_equivalent for r in res_fixed)


def test_pattern6_union_variant_equivalence(tmp_path):
    c_file = tmp_path / "p6.c"
    rust_fixed = tmp_path / "p6_fixed.rs"

    c_file.write_text("""
typedef union {
    int i;
    float f;
} Number;

void init_as_int(Number *n, int v) {
    n->i = v;
}

int get_as_int(Number *n) {
    return n->i;
}

int caller_demo(void) {
    Number n;
    init_as_int(&n, 42);
    return get_as_int(&n);
}

int main() {
    return caller_demo();
}
""")

    rust_fixed.write_text("""
#[repr(C)]
pub union Number {
    pub i: i32,
    pub f: f32,
}

#[no_mangle]
pub unsafe extern "C" fn init_as_int(n: *mut Number, v: i32) {
    (*n).i = v;
}

#[no_mangle]
pub unsafe extern "C" fn get_as_int(n: *mut Number) -> i32 {
    (*n).i
}

#[no_mangle]
pub extern "C" fn caller_demo() -> i32 {
    let mut n = Number { i: 0 };
    unsafe {
        init_as_int(&mut n as *mut Number, 42);
        get_as_int(&mut n as *mut Number)
    }
}

fn main() {
    let res = caller_demo();
    std::process::exit(res);
}
""")

    res_fixed = run_rustsketch(
        c_path=str(c_file),
        rust_path=str(rust_fixed),
        build_dir=str(tmp_path / "build_p6_fixed")
    )
    assert len(res_fixed) >= 1
    assert all(r.is_equivalent for r in res_fixed)



