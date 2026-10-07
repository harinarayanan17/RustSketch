int helper_arith(int a, int b) {
    return (a * 3 + b) ^ ((a - b) * 2);
}

int caller_eval(int x, int y) {
    return helper_arith(x + 1, y - 2);
}

int main() {
    return caller_eval(5, 7);
}
