#include "component_a/service.h"
#include "shared/api.h"

namespace component_a {
std::string run() {
    return "Component A using " + shared::get_shared_message();
}
}  // namespace component_a

