int g_counter = 0;

int helper_inc(int val) {
    g_counter += val;
    return g_counter;
}

int caller_work(int x) {
    return helper_inc(x * 2);
}

int main() {
    return caller_work(1);
}
