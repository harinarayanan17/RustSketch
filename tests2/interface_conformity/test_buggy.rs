#[allow(dead_code)]
fn hidden_unexported(x: i32) -> i32 {
    x * 4
}

#[no_mangle]
pub extern "C" fn caller_process(val: i32) -> i32 {
    hidden_unexported(val) + 1
}

fn main() {
    let res = caller_process(5);
    std::process::exit(res);
}
