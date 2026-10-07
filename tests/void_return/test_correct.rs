#[no_mangle]
pub unsafe extern "C" fn update_buffer(ptr: *mut i32, val: i32) {
    *ptr = val ^ 0x42;
}

#[no_mangle]
pub extern "C" fn caller_void_test(input: i32) -> i32 {
    let mut buf = 0;
    unsafe {
        update_buffer(&mut buf as *mut i32, input);
    }
    buf
}

fn main() {
    let res = caller_void_test(10);
    std::process::exit(res);
}
