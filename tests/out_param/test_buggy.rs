#[no_mangle]
pub unsafe extern "C" fn helper_scale(val: *mut i32, factor: i32) {
    // Hallucination: drops pointer write-back, computing locally as pass-by-value
    let _local = (*val) * factor + 5;
}

#[no_mangle]
pub extern "C" fn caller_calc(initial: i32, factor: i32) -> i32 {
    let mut x = initial;
    unsafe {
        helper_scale(&mut x as *mut i32, factor);
    }
    x
}

fn main() {
    let res = caller_calc(10, 2);
    std::process::exit(res);
}
