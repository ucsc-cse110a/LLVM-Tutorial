#include <iostream>
#include <cstdint>
#include <cstdlib>

extern "C" void dyadic_func(int32_t *a, int32_t *b);

int main(int argc, char* argv[]) {
    if (argc != 3) {
        std::cerr << "Usage: " << argv[0] << " <int a> <int b>\n";
        return 1;
    }

	int32_t ai = std::atoi(argv[1]);
	int32_t bi = std::atoi(argv[2]);
    int32_t *a = &ai;
    int32_t *b = &bi;

    std::cout << "Before:\n";
    std::cout << "a = " << *a << ", b = " << *b << "\n";

    dyadic_func(a, b);

    std::cout << "After:\n";
    std::cout << "a = " << *a << ", b = " << *b << "\n";

    return 0;
}
