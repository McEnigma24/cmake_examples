#include "app_config.h"
#include "manual_vendor/message.h"

#include <iostream>

int main() {
    std::cout << kVendorAppName << ": " << manual_vendor::message() << std::endl;
    return 0;
}

