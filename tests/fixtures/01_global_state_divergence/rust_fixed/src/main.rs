// Semantically equivalent Rust translation:
// Preserves static mut G_COUNTER mutation and logic identically to C

#[no_mangle]
static mut G_COUNTER: i32 = 10;

#[no_mangle]
pub extern "C" fn helper_update(val: i32) -> i32 {
    unsafe {
        G_COUNTER += val * 3;
        G_COUNTER
    }
}

#[no_mangle]
pub extern "C" fn caller_compute(a: i32, b: i32) -> i32 {
    let r1 = helper_update(a);
    let r2 = helper_update(b);
    unsafe {
        r1 + r2 + G_COUNTER
    }
}

fn main() {
    let res = caller_compute(1, 5);
    std::process::exit(res);
}
