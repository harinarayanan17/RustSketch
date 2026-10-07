#[no_mangle]
pub static mut g_counter: i32 = 0;

#[no_mangle]
pub extern "C" fn helper_inc(val: i32) -> i32 {
    unsafe {
        g_counter += val;
        g_counter
    }
}

#[no_mangle]
pub extern "C" fn caller_work(x: i32) -> i32 {
    helper_inc(x * 2)
}

fn main() {
    let res = caller_work(1);
    std::process::exit(res);
}
