#include <iostream>

#include "util.h"       // local
#include "math.h"       // internal lib
#include "json.hpp"     // external lib

int main()
{
    var(math::add(2, 2));
    var(nlohmann::json::parse("{\"name\": \"John\", \"age\": 30}").at("name").get<std::string>());

    return 0;
}
