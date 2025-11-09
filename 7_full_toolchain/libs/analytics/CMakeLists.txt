cmake_minimum_required(VERSION 3.20)

set(CONST_TARGET_NAME "analytics")

include_directories(_inc)

aux_source_directory(_src SOURCES)

string(LENGTH "${CMAKE_SOURCE_DIR}/" SOURCE_PATH_SIZE)
add_definitions(-DSOURCE_PATH_SIZE=${SOURCE_PATH_SIZE})

add_library(${CONST_TARGET_NAME} STATIC ${SOURCES})

target_include_directories(${CONST_TARGET_NAME}
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/_inc
)

# analytics depends on core for runtime behaviour and headers; we mark it PUBLIC so downstream
# consumers also link core automatically.
target_link_libraries(${CONST_TARGET_NAME} PUBLIC core)

target_compile_features(${CONST_TARGET_NAME} PUBLIC cxx_std_20)

