cmake_minimum_required(VERSION 3.20)

# Adds an internal static library built from a subdirectory.
project(InternalLibExample LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# We keep reusable code in libs/math with its own CMakeLists.txt.
add_subdirectory(libs/math)

add_executable(app_with_math src/main.cpp)

# Link our internal library; PRIVATE means the dependency is not re-exposed to consumers.
target_link_libraries(app_with_math PRIVATE mathlib)

# Because mathlib provides headers in a subdirectory, we inherited include paths via
# target_include_directories in the library CMakeLists (see libs/math/CMakeLists.txt).

