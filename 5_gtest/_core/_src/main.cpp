#include <iostream>

#include "util.h"       // local
#include "math.h"       // internal
#include "json.hpp"     // external

int main()
{
    var(math::add(2, 2));
    var(nlohmann::json::parse("{\"name\": \"John\", \"age\": 30}").at("name").get<std::string>());

    return 0;
}
