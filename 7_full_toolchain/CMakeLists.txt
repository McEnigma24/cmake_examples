cmake_minimum_required(VERSION 3.23)

# Integrates multiple dependency strategies (internal libs, manual vendor, FetchContent) and
# documents cross-compilation via a toolchain file.
project(FullToolchainExample LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(FetchContent)

FetchContent_Declare(
    fetched_vendor
    SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../05_fetchcontent/external/fetched_vendor
)
FetchContent_MakeAvailable(fetched_vendor)

# Internal reusable components.
add_subdirectory(libs/core)
add_subdirectory(libs/analytics)

# Manually managed external dependency (e.g., git submodule).
add_subdirectory(external/manual_vendor EXCLUDE_FROM_ALL)

add_executable(full_toolchain_app src/main.cpp)

# Dependency rationale:
# - analytics: domain logic; brings core transitively.
# - manual_vendor: manually vendored third-party features (headers + lib).
# - fetched_vendor: automatically populated via FetchContent to simulate remote dependency.
target_link_libraries(full_toolchain_app
    PRIVATE
        analytics
        manual_vendor
        fetched_vendor
)

# Cross-compilation: configure using e.g.
#   cmake --preset arm-debug
# This preset points to toolchains/arm-gcc-toolchain.cmake, defining compilers/sysroot.

