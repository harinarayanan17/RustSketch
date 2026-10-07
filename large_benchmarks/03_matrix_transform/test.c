typedef struct {
    int x;
    int y;
    int z;
} Vec3;

typedef struct {
    int m00; int m01; int m02;
    int m10; int m11; int m12;
    int m20; int m21; int m22;
} Mat3x3;

void vec3_init(Vec3 *v, int x, int y, int z) {
    v->x = x;
    v->y = y;
    v->z = z;
}

int vec3_dot(const Vec3 *a, const Vec3 *b) {
    return (a->x * b->x) + (a->y * b->y) + (a->z * b->z);
}

void vec3_scale(Vec3 *v, int factor) {
    v->x *= factor;
    v->y *= factor;
    v->z *= factor;
}

void mat3_transform(const Mat3x3 *m, const Vec3 *src, Vec3 *dst) {
    dst->x = (m->m00 * src->x) + (m->m01 * src->y) + (m->m02 * src->z);
    dst->y = (m->m10 * src->x) + (m->m11 * src->y) + (m->m12 * src->z);
    dst->z = (m->m20 * src->x) + (m->m21 * src->y) + (m->m22 * src->z);
}

int caller_render_pipeline(int x, int y, int z, int scale) {
    Vec3 input_v;
    vec3_init(&input_v, x, y, z);
    vec3_scale(&input_v, scale);

    Mat3x3 mat = {
        2, 1, 0,
        0, 2, 1,
        1, 0, 2
    };

    Vec3 out_v;
    mat3_transform(&mat, &input_v, &out_v);

    return vec3_dot(&input_v, &out_v);
}

int main() {
    return caller_render_pipeline(1, 2, 3, 2);
}
