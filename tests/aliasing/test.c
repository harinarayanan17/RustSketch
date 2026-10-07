void update_alias(int *a, int *b) {
    *a = 15;
    *b = 30;
}

int caller_alias(void) {
    int x = 0;
    update_alias(&x, &x);
    return x;
}

int main() {
    return caller_alias();
}
