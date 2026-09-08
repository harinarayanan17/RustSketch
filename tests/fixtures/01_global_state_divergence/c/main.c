#include "state.h"

int caller_compute(int a, int b) {
    int r1 = helper_update(a);
    int r2 = helper_update(b);
    return r1 + r2 + g_counter;
}

int main(int argc, char **argv) {
    return caller_compute(argc, 5);
}
