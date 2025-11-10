add_library(shared_core STATIC)

target_sources(
    shared_core
    PRIVATE
        src/config.cpp
        src/math.cpp
)

target_include_directories(
    shared_core
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/include
)

target_link_libraries(
    shared_core
    PUBLIC
        project_warnings
        nlohmann_json::nlohmann_json
)

target_compile_definitions(shared_core PUBLIC SOURCE_PATH_SIZE=${SOURCE_PATH_SIZE})

target_compile_features(shared_core PUBLIC cxx_std_20)
