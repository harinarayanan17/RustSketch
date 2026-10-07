#[no_mangle]
pub extern "C" fn helper_arith(a: i32, b: i32) -> i32 {
    // Hallucination: changes XOR ^ to OR |
    (a * 3 + b) | ((a - b) * 2)
}

#[no_mangle]
pub extern "C" fn caller_eval(x: i32, y: i32) -> i32 {
    helper_arith(x + 1, y - 2)
}

fn main() {
    let res = caller_eval(5, 7);
    std::process::exit(res);
}
