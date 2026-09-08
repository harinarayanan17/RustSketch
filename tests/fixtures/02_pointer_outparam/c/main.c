#include "transform.h"

int caller_transform(int initial, int scale, int offset) {
    int target = initial;
    transform_ptr(&target, scale, offset);
    return target;
}

int main(int argc, char **argv) {
    return caller_transform(argc, 2, 7);
}
