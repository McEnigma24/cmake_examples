cmake_minimum_required(VERSION 3.20)

project(FetchedVendor LANGUAGES CXX)

add_library(fetched_vendor STATIC
    src/vendor.cpp
)

target_include_directories(fetched_vendor
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/include
)

target_compile_features(fetched_vendor PUBLIC cxx_std_17)

