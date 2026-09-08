// Buggy Rust translation:
// Divergence 1: Local variable used instead of persisting global mutation
// Divergence 2: Incorrect multiplier (val * 2 instead of val * 3)

#[no_mangle]
static mut G_COUNTER: i32 = 10;

#[no_mangle]
pub extern "C" fn helper_update(val: i32) -> i32 {
    // Buggy: Does not mutate static G_COUNTER, acts like a pass-by-value local state
    let local_counter = 10;
    local_counter + (val * 2)
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
