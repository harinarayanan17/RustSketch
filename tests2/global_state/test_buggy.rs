#[no_mangle]
pub static mut g_counter: i32 = 0;

#[no_mangle]
pub extern "C" fn helper_inc(val: i32) -> i32 {
    // Hallucination: operates on a local variable copy, failing to update static mut g_counter
    let mut local_counter = 0;
    local_counter += val;
    local_counter
}

#[no_mangle]
pub extern "C" fn caller_work(x: i32) -> i32 {
    helper_inc(x * 2)
}

fn main() {
    let res = caller_work(1);
    std::process::exit(res);
}
