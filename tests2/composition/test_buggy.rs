#[no_mangle]
pub extern "C" fn helper_step1(a: i32) -> i32 {
    a * 2 + 3
}

#[no_mangle]
pub extern "C" fn helper_step2(b: i32) -> i32 {
    b ^ 0x0F
}

#[no_mangle]
pub unsafe extern "C" fn helper_step3(state: *mut i32, factor: i32) {
    // Hallucination: helper drops the out-parameter state transfer (no write to *state)
    let _local = *state + factor;
}

#[no_mangle]
pub extern "C" fn caller_pipeline(input: i32, factor: i32) -> i32 {
    let s1 = helper_step1(input);
    let s2 = helper_step2(s1);
    let mut res = s2;
    unsafe {
        helper_step3(&mut res as *mut i32, factor);
    }
    res
}

fn main() {
    let r = caller_pipeline(10, 5);
    std::process::exit(r);
}
