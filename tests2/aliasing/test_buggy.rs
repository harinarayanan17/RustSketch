#[no_mangle]
pub unsafe extern "C" fn update_alias(a: *mut i32, b: *mut i32) {
    // Hallucination: assumes a and b do not alias, reordering write operations
    *b = 30;
    *a = 15;
}

#[no_mangle]
pub extern "C" fn caller_alias() -> i32 {
    let mut x = 0;
    unsafe {
        update_alias(&mut x as *mut i32, &mut x as *mut i32);
    }
    x
}

fn main() {
    let res = caller_alias();
    std::process::exit(res);
}
