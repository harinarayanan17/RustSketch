#[no_mangle]
pub static mut g_counter: i32 = 0;

#[no_mangle]
pub unsafe extern "C" fn complex_op(p: *mut *mut i32, delta: i32) {
    g_counter += delta;
    *p = std::ptr::null_mut();
}

#[no_mangle]
pub extern "C" fn caller_complex(delta: i32) -> i32 {
    let mut target = 50;
    let mut p = &mut target as *mut i32;
    unsafe {
        complex_op(&mut p as *mut *mut i32, delta);
        if p.is_null() { g_counter } else { -1 }
    }
}

fn main() {
    let res = caller_complex(10);
    std::process::exit(res);
}
