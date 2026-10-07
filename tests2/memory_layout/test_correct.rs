#[repr(C)]
pub union ValueUnion {
    pub i: i32,
    pub f: f32,
}

#[repr(C)]
pub struct PaddedStruct {
    pub tag: u8,
    pub data: i32,
}

#[no_mangle]
pub unsafe extern "C" fn init_union(u: *mut ValueUnion, v: i32) {
    (*u).i = v;
}

#[no_mangle]
pub unsafe extern "C" fn get_union(u: *mut ValueUnion) -> i32 {
    (*u).i
}

#[no_mangle]
pub unsafe extern "C" fn init_struct(s: *mut PaddedStruct, t: u8, d: i32) {
    (*s).tag = t;
    (*s).data = d;
}

#[no_mangle]
pub unsafe extern "C" fn read_struct(s: *mut PaddedStruct) -> i32 {
    (*s).data
}

#[no_mangle]
pub extern "C" fn caller_layout(val: i32) -> i32 {
    let mut u = ValueUnion { i: 0 };
    unsafe {
        init_union(&mut u as *mut ValueUnion, val);
        let mut s = PaddedStruct { tag: 0, data: 0 };
        init_struct(&mut s as *mut PaddedStruct, b'A', get_union(&mut u as *mut ValueUnion));
        read_struct(&mut s as *mut PaddedStruct)
    }
}

fn main() {
    let res = caller_layout(42);
    std::process::exit(res);
}
