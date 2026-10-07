int helper_step1(int a) {
    return a * 2 + 3;
}

int helper_step2(int b) {
    return b ^ 0x0F;
}

void helper_step3(int *state, int factor) {
    *state = (*state) + factor;
}

int caller_pipeline(int input, int factor) {
    int s1 = helper_step1(input);
    int s2 = helper_step2(s1);
    int res = s2;
    helper_step3(&res, factor);
    return res;
}

int main() {
    return caller_pipeline(10, 5);
}
