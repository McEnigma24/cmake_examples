#include "component_b/service.h"
#include "shared/api.h"

namespace component_b {
std::string run() {
    return "Component B integrating " + shared::get_shared_message();
}
}  // namespace component_b

