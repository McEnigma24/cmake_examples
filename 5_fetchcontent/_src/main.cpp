#include "app_config.h"
#include "fetched/vendor.h"

#include <iostream>

int main() {
    std::cout << kFetchAppName << ": " << fetched::fetched_message() << std::endl;
    return 0;
}

