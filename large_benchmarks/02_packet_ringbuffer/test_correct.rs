#[repr(C)]
pub struct RingBuffer {
    pub head: i32,
    pub tail: i32,
    pub count: i32,
    pub capacity: i32,
    pub dropped_packets: i32,
}

#[repr(C)]
pub struct PacketHeader {
    pub magic: i32,
    pub payload_length: i32,
    pub status_flags: i32,
}

#[no_mangle]
pub unsafe extern "C" fn ring_init(rb: *mut RingBuffer, cap: i32) {
    (*rb).head = 0;
    (*rb).tail = 0;
    (*rb).count = 0;
    (*rb).capacity = if cap > 0 && cap <= 16 { cap } else { 8 };
    (*rb).dropped_packets = 0;
}

#[no_mangle]
pub unsafe extern "C" fn ring_push(rb: *mut RingBuffer, item: i32) -> i32 {
    if (*rb).count >= (*rb).capacity {
        (*rb).dropped_packets += 1;
        0
    } else {
        (*rb).head = ((*rb).head + 1) % (*rb).capacity;
        (*rb).count += 1;
        item ^ 0xAA
    }
}

#[no_mangle]
pub unsafe extern "C" fn parse_header(hdr: *mut PacketHeader, expected_magic: i32) -> i32 {
    if (*hdr).magic != expected_magic {
        (*hdr).status_flags |= 0x01;
        -1
    } else {
        (*hdr).status_flags &= !0x01;
        (*hdr).payload_length
    }
}

#[no_mangle]
pub extern "C" fn caller_process_frame(magic_in: i32, len_in: i32) -> i32 {
    let mut rb = RingBuffer {
        head: 0,
        tail: 0,
        count: 0,
        capacity: 0,
        dropped_packets: 0,
    };
    unsafe {
        ring_init(&mut rb as *mut RingBuffer, 4);

        let mut hdr = PacketHeader {
            magic: magic_in,
            payload_length: len_in,
            status_flags: 0,
        };

        let parse_res = parse_header(&mut hdr as *mut PacketHeader, 0x55AA);
        if parse_res >= 0 {
            ring_push(&mut rb as *mut RingBuffer, parse_res);
            ring_push(&mut rb as *mut RingBuffer, parse_res + 1);
        }

        rb.count + (hdr.status_flags & 0xFF)
    }
}

fn main() {
    let res = caller_process_frame(0x55AA, 10);
    std::process::exit(res);
}
