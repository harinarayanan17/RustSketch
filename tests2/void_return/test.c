void update_buffer(int *ptr, int val) {
    *ptr = val ^ 0x42;
}

int caller_void_test(int input) {
    int buf = 0;
    update_buffer(&buf, input);
    return buf;
}

int main() {
    return caller_void_test(10);
}
