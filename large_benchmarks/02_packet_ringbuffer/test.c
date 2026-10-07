typedef struct {
    int head;
    int tail;
    int count;
    int capacity;
    int dropped_packets;
} RingBuffer;

typedef struct {
    int magic;
    int payload_length;
    int status_flags;
} PacketHeader;

void ring_init(RingBuffer *rb, int cap) {
    rb->head = 0;
    rb->tail = 0;
    rb->count = 0;
    rb->capacity = (cap > 0 && cap <= 16) ? cap : 8;
    rb->dropped_packets = 0;
}

int ring_push(RingBuffer *rb, int item) {
    if (rb->count >= rb->capacity) {
        rb->dropped_packets++;
        return 0;
    }
    rb->head = (rb->head + 1) % rb->capacity;
    rb->count++;
    return item ^ 0xAA;
}

int parse_header(PacketHeader *hdr, int expected_magic) {
    if (hdr->magic != expected_magic) {
        hdr->status_flags |= 0x01;
        return -1;
    }
    hdr->status_flags &= ~0x01;
    return hdr->payload_length;
}

int caller_process_frame(int magic_in, int len_in) {
    RingBuffer rb;
    ring_init(&rb, 4);

    PacketHeader hdr;
    hdr.magic = magic_in;
    hdr.payload_length = len_in;
    hdr.status_flags = 0;

    int parse_res = parse_header(&hdr, 0x55AA);
    if (parse_res >= 0) {
        ring_push(&rb, parse_res);
        ring_push(&rb, parse_res + 1);
    }

    return rb.count + (hdr.status_flags & 0xFF);
}

int main() {
    return caller_process_frame(0x55AA, 10);
}
