#[no_mangle]
pub extern "C" fn process_item_mut(x: i32) -> i32 {
    x * 4
}

#[no_mangle]
pub extern "C" fn caller_process(val: i32) -> i32 {
    process_item_mut(val) + 1
}

fn main() {
    let res = caller_process(5);
    std::process::exit(res);
}
