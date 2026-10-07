const FNV_OFFSET_BASIS: u32 = 2166136261;
const FNV_PRIME: u32 = 16777619;

#[no_mangle]
pub extern "C" fn hash_init() -> u32 {
    FNV_OFFSET_BASIS
}

#[no_mangle]
pub extern "C" fn hash_step(current_hash: u32, byte_val: u32) -> u32 {
    (current_hash ^ (byte_val & 0xFF)).wrapping_mul(FNV_PRIME)
}

#[no_mangle]
pub extern "C" fn hash_avalanche(mut h: u32) -> u32 {
    // Hallucination: shifts by 15 instead of 16 in avalanche mixer
    h ^= h >> 15;
    h = h.wrapping_mul(0x85ebca6b);
    h ^= h >> 13;
    h = h.wrapping_mul(0xc2b2ae35);
    h ^= h >> 16;
    h
}

#[no_mangle]
pub unsafe extern "C" fn hash_update_token(hash_state: *mut u32, part1: u32, part2: u32) {
    *hash_state = hash_step(*hash_state, part1);
    *hash_state = hash_step(*hash_state, part2);
}

#[no_mangle]
pub extern "C" fn caller_hash_pipeline(word1: u32, word2: u32) -> i32 {
    let mut h = hash_init();
    unsafe {
        hash_update_token(&mut h as *mut u32, word1, word2);
    }
    hash_avalanche(h) as i32
}

fn main() {
    let res = caller_hash_pipeline(0x1234, 0x5678);
    std::process::exit(res);
}
