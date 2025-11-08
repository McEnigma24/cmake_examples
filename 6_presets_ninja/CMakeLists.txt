cmake_minimum_required(VERSION 3.20)

# Highlights the use of CMake presets and generator selection (Ninja in this case).
project(PresetsNinjaExample LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_library(helpers STATIC
    src/tools.cpp
)
target_include_directories(helpers PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/src)

add_executable(presets_demo src/main.cpp)
target_link_libraries(presets_demo PRIVATE helpers)

# We expect this directory to be configured via `cmake --preset ninja-debug` (see CMakePresets.json).
# The preset pins the Ninja generator and build directory, so we do not rely on manual `-G` flags.

