typedef union {
    int i;
    float f;
} ValueUnion;

typedef struct {
    char tag;
    int data;
} PaddedStruct;

void init_union(ValueUnion *u, int v) {
    u->i = v;
}

int get_union(ValueUnion *u) {
    return u->i;
}

void init_struct(PaddedStruct *s, char t, int d) {
    s->tag = t;
    s->data = d;
}

int read_struct(PaddedStruct *s) {
    return s->data;
}

int caller_layout(int val) {
    ValueUnion u;
    init_union(&u, val);
    PaddedStruct s;
    init_struct(&s, 'A', get_union(&u));
    return read_struct(&s);
}

int main() {
    return caller_layout(42);
}
