int process_item(int x) {
    return x * 4;
}

int caller_process(int val) {
    return process_item(val) + 1;
}

int main() {
    return caller_process(5);
}
