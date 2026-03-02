#include <cstdint>
extern "C" void dyadic_func(int32_t *a, int32_t *b) {
    *a = *a + *b;
	*b = *a + *b;
};

