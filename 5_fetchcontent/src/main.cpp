#include "fetched/vendor.h"
#include <iostream>

int main() {
    std::cout << "FetchContent says: " << fetched::fetched_message() << std::endl;
    return 0;
}

