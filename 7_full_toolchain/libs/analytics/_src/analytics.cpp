#include "analytics/analytics.h"
#include "core/core.h"

namespace analytics {
std::string summarize_usage() {
    return "Analytics summary for " + core::app_name();
}
}  // namespace analytics

