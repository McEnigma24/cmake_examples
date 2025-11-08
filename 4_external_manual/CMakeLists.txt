cmake_minimum_required(VERSION 3.20)

# Example: manually vendored dependency that we treat similar to a git submodule.
project(ExternalManualExample LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Because we control the vendor directory, we can add it as a subdirectory. Setting
# EXCLUDE_FROM_ALL avoids building it unless required by another target.
add_subdirectory(external/manual_lib EXCLUDE_FROM_ALL)

add_executable(app_with_vendor src/main.cpp)

# Link against the vendor library; comment clarifies dependency reasoning.
# Here we use PRIVATE because we don't re-expose manual_vendor to downstream consumers.
target_link_libraries(app_with_vendor PRIVATE manual_vendor)

# If the external project had transitive dependencies, we would document them here to avoid surprises.

