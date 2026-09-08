#include "state.h"

int g_counter = 10;

int helper_update(int val) {
    g_counter += (val * 3);
    return g_counter;
}
