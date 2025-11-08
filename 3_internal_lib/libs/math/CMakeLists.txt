cmake_minimum_required(VERSION 3.20)

# Define a target representing reusable math utilities within the project.
add_library(mathlib STATIC math.cpp)

target_include_directories(mathlib
    PUBLIC  # Headers must be visible to anything that links mathlib.
        ${CMAKE_CURRENT_SOURCE_DIR}
)

# In a larger project we would control warnings/compile options here as well.

