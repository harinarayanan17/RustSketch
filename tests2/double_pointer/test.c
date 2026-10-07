void reset_ptr(int **p) {
    *p = 0;
}

int caller_reset(void) {
    int target = 42;
    int *p = &target;
    reset_ptr(&p);
    return (p == 0) ? 1 : 0;
}

int main() {
    return caller_reset();
}
