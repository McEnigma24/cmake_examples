#include "shared/config.hpp"

#include "shared/util.hpp"

#include <nlohmann/json.hpp>

namespace shared
{
void print_component_banner(std::string_view component_name)
{
    const nlohmann::json payload = {
        {"component", component_name},
    };

    line("Launching component with metadata: " + payload.dump());
}
} // namespace shared

