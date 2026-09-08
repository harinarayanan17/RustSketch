#include "transform.h"

void transform_ptr(int *ptr, int scale, int offset) {
    if (ptr != 0) {
        *ptr = (*ptr * scale) + offset;
    }
}
