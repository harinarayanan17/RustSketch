#[no_mangle]
pub unsafe extern "C" fn reset_ptr(p: *mut *mut i32) {
    // Hallucination: flattens to mutating target data (**p = 0) rather than pointer address (*p = NULL)
    if !(*p).is_null() {
        **p = 0;
    }
}

#[no_mangle]
pub extern "C" fn caller_reset() -> i32 {
    let mut target = 42;
    let mut p = &mut target as *mut i32;
    unsafe {
        reset_ptr(&mut p as *mut *mut i32);
    }
    if p.is_null() { 1 } else { 0 }
}

fn main() {
    let res = caller_reset();
    std::process::exit(res);
}
