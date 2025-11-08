cmake_minimum_required(VERSION 3.20)

project(ManualVendorFull LANGUAGES CXX)

add_library(manual_vendor STATIC
    src/info.cpp
)

target_include_directories(manual_vendor
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/include
)

target_compile_features(manual_vendor PUBLIC cxx_std_20)

