cmake_minimum_required(VERSION 3.20)

# Simulates a third-party project we vendor manually (e.g., as a git submodule).
project(ManualVendor LANGUAGES CXX)

add_library(manual_vendor STATIC
    src/message.cpp
)

target_include_directories(manual_vendor
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/include
)

# External projects may have their own compile features; we propagate requirements publicly.
target_compile_features(manual_vendor PUBLIC cxx_std_17)

