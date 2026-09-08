// Semantically equivalent Rust translation:
// transform_ptr takes a raw mutable pointer or &mut and mutates the caller's target variable

#[no_mangle]
pub unsafe extern "C" fn transform_ptr(ptr: *mut i32, scale: i32, offset: i32) {
    if !ptr.is_null() {
        *ptr = (*ptr * scale) + offset;
    }
}

#[no_mangle]
pub extern "C" fn caller_transform(initial: i32, scale: i32, offset: i32) -> i32 {
    let mut target = initial;
    unsafe {
        transform_ptr(&mut target as *mut i32, scale, offset);
    }
    target
}

fn main() {
    let res = caller_transform(1, 2, 7);
    std::process::exit(res);
}
