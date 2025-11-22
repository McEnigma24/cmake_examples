#include <iostream>

#include "util.h"       // local
#include "math.h"       // internal lib
#include "json.hpp"     // external lib

int main()
{
    var(math::add(2, 2));
    var(nlohmann::json::parse("{\"name\": \"John\", \"age\": 30}").at("name").get<std::string>());

    #ifdef MY_MACRO
        std::cout << "MY_MACRO is defined" << std::endl;
    #else
        std::cout << "MY_MACRO is not defined" << std::endl;
    #endif

    #ifdef MY_MACRO_2
        std::cout << "MY_MACRO_2 is defined" << std::endl;
    #else
        std::cout << "MY_MACRO_2 is not defined" << std::endl;
    #endif

    std::cin.get();

    return 0;
}
