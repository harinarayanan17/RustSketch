int g_counter = 0;

void complex_op(int **p, int delta) {
    g_counter += delta;
    *p = 0;
}

int caller_complex(int delta) {
    int target = 50;
    int *p = &target;
    complex_op(&p, delta);
    return (p == 0) ? g_counter : -1;
}

int main() {
    return caller_complex(10);
}
