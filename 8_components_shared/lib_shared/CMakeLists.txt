cmake_minimum_required(VERSION 3.20)

project(SharedLib LANGUAGES CXX)

set(CONST_TARGET_NAME "shared_lib")

include_directories(_inc)

aux_source_directory(_src SOURCES)

string(LENGTH "${CMAKE_SOURCE_DIR}/" SOURCE_PATH_SIZE)
add_definitions(-DSOURCE_PATH_SIZE=${SOURCE_PATH_SIZE})

add_library(${CONST_TARGET_NAME} STATIC ${SOURCES})
target_include_directories(${CONST_TARGET_NAME}
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/_inc
)

