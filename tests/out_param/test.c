void helper_scale(int *val, int factor) {
    *val = (*val) * factor + 5;
}

int caller_calc(int initial, int factor) {
    int x = initial;
    helper_scale(&x, factor);
    return x;
}

int main() {
    return caller_calc(10, 2);
}
