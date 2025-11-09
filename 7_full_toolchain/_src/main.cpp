#include "analytics/analytics.h"
#include "app_config.h"
#include "core/core.h"
#include "fetched/vendor.h"
#include "manual_vendor/info.h"

#include <iostream>

int main() {
    std::cout << kAppBanner << '\n';
    std::cout << core::app_name() << " loaded.\n";
    std::cout << analytics::summarize_usage() << '\n';
    std::cout << fetched::fetched_message() << '\n';
    std::cout << manual_vendor::info() << std::endl;
    return 0;
}

