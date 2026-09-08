// Buggy Rust translation:
// transform_ptr takes a value instead of mutable pointer / doesn't mutate caller's value

#[no_mangle]
pub extern "C" fn transform_ptr(mut val: i32, scale: i32, offset: i32) {
    // Buggy: modifying local val does not reflect in caller
    val = (val * scale) + offset;
}

#[no_mangle]
pub extern "C" fn caller_transform(initial: i32, scale: i32, offset: i32) -> i32 {
    let target = initial;
    transform_ptr(target, scale, offset);
    target // Returns unmodified initial value!
}

fn main() {
    let res = caller_transform(1, 2, 7);
    std::process::exit(res);
}
