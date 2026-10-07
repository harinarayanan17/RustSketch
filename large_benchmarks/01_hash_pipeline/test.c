#define FNV_OFFSET_BASIS 2166136261U
#define FNV_PRIME 16777619U

unsigned int hash_init(void) {
    return FNV_OFFSET_BASIS;
}

unsigned int hash_step(unsigned int current_hash, unsigned int byte_val) {
    return (current_hash ^ (byte_val & 0xFF)) * FNV_PRIME;
}

unsigned int hash_avalanche(unsigned int h) {
    h ^= h >> 16;
    h *= 0x85ebca6b;
    h ^= h >> 13;
    h *= 0xc2b2ae35;
    h ^= h >> 16;
    return h;
}

void hash_update_token(unsigned int *hash_state, unsigned int part1, unsigned int part2) {
    *hash_state = hash_step(*hash_state, part1);
    *hash_state = hash_step(*hash_state, part2);
}

int caller_hash_pipeline(unsigned int word1, unsigned int word2) {
    unsigned int h = hash_init();
    hash_update_token(&h, word1, word2);
    return (int)hash_avalanche(h);
}

int main() {
    return caller_hash_pipeline(0x1234, 0x5678);
}
