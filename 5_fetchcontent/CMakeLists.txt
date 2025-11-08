cmake_minimum_required(VERSION 3.20)

# Demonstrates FetchContent, which downloads/configures dependencies during the configure step.
project(FetchContentExample LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(FetchContent)

# Real-world usage would fetch from a remote VCS/URL. For an offline-friendly demo we point to a
# local directory, but the API surface is identical.
FetchContent_Declare(
    fetched_vendor
    SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/external/fetched_vendor
    # Alternative (real) usage:
    # GIT_REPOSITORY https://github.com/example/vendor.git
    # GIT_TAG        v1.2.3
)

# Populate + add_subdirectory in one step; creates the target defined by the dependency's CMakeLists.
FetchContent_MakeAvailable(fetched_vendor)

add_executable(app_with_fetch src/main.cpp)

# Link against the fetched dependency. Because fetched_vendor exported PUBLIC include directories,
# the include path is automatically visible to this target.
target_link_libraries(app_with_fetch PRIVATE fetched_vendor)

