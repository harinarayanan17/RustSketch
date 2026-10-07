#[repr(C)]
pub struct Vec3 {
    pub x: i32,
    pub y: i32,
    pub z: i32,
}

#[repr(C)]
pub struct Mat3x3 {
    pub m00: i32, pub m01: i32, pub m02: i32,
    pub m10: i32, pub m11: i32, pub m12: i32,
    pub m20: i32, pub m21: i32, pub m22: i32,
}

#[no_mangle]
pub unsafe extern "C" fn vec3_init(v: *mut Vec3, x: i32, y: i32, z: i32) {
    (*v).x = x;
    (*v).y = y;
    (*v).z = z;
}

#[no_mangle]
pub unsafe extern "C" fn vec3_dot(a: *const Vec3, b: *const Vec3) -> i32 {
    ((*a).x * (*b).x) + ((*a).y * (*b).y) + ((*a).z * (*b).z)
}

#[no_mangle]
pub unsafe extern "C" fn vec3_scale(v: *mut Vec3, factor: i32) {
    (*v).x *= factor;
    (*v).y *= factor;
    (*v).z *= factor;
}

#[no_mangle]
pub unsafe extern "C" fn mat3_transform(m: *const Mat3x3, src: *const Vec3, dst: *mut Vec3) {
    (*dst).x = ((*m).m00 * (*src).x) + ((*m).m01 * (*src).y) + ((*m).m02 * (*src).z);
    (*dst).y = ((*m).m10 * (*src).x) + ((*m).m11 * (*src).y) + ((*m).m12 * (*src).z);
    (*dst).z = ((*m).m20 * (*src).x) + ((*m).m21 * (*src).y) + ((*m).m22 * (*src).z);
}

#[no_mangle]
pub extern "C" fn caller_render_pipeline(x: i32, y: i32, z: i32, scale: i32) -> i32 {
    let mut input_v = Vec3 { x: 0, y: 0, z: 0 };
    unsafe {
        vec3_init(&mut input_v as *mut Vec3, x, y, z);
        vec3_scale(&mut input_v as *mut Vec3, scale);

        let mat = Mat3x3 {
            m00: 2, m01: 1, m02: 0,
            m10: 0, m11: 2, m12: 1,
            m20: 1, m21: 0, m22: 2,
        };

        let mut out_v = Vec3 { x: 0, y: 0, z: 0 };
        mat3_transform(&mat as *const Mat3x3, &input_v as *const Vec3, &mut out_v as *mut Vec3);

        vec3_dot(&input_v as *const Vec3, &out_v as *const Vec3)
    }
}

fn main() {
    let res = caller_render_pipeline(1, 2, 3, 2);
    std::process::exit(res);
}
