add_library(shared_math STATIC)

target_sources(
    shared_math
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/_core/_src/math.cpp
)

target_include_directories(
    shared_math
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/_core/_inc
)

target_compile_features(shared_math PUBLIC cxx_std_20)
