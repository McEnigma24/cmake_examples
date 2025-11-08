cmake_minimum_required(VERSION 3.20)

add_library(analytics STATIC
    src/analytics.cpp
)

target_include_directories(analytics
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/include
)

# analytics depends on core for runtime behaviour and headers; we mark it PUBLIC so downstream
# consumers also link core automatically.
target_link_libraries(analytics PUBLIC core)

target_compile_features(analytics PUBLIC cxx_std_20)

