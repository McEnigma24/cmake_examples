cmake_minimum_required(VERSION 3.20)

# Demonstrates aggregating multiple translation units into one executable target.
project(MultiSourceExample LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_executable(multi_app)

# Instead of listing sources inline in add_executable, use target_sources to make later
# refactors (e.g., conditional files per platform) easier.
target_sources(multi_app PRIVATE
    src/main.cpp
    src/util.cpp
)

target_include_directories(multi_app PRIVATE src)

# Comments: CMake tracks dependencies automatically per translation unit.
# This example still uses the default Make generator but shows scaling source organization.

