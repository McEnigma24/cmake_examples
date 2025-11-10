#include <string>
#include <string_view>

#include <nlohmann/json.hpp>

#include "shared/config.hpp"
#include "shared/math.hpp"
#include "shared/util.hpp"

int main()
{
    constexpr std::string_view component_name = COMPONENT_NAME;

    shared::print_component_banner(component_name);

    var(shared::add(2, 2));

    const auto parsed = nlohmann::json::parse("{\"name\": \"John\", \"age\": 30}");
    var(parsed.at("name").get<std::string>());

    #ifdef MY_MACRO
        std::cout << "MY_MACRO is defined" << std::endl;
    #else
        std::cout << "MY_MACRO is not defined" << std::endl;
    #endif

    return 0;
}
