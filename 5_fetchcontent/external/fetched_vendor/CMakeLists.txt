cmake_minimum_required(VERSION 3.20)

project(FetchedVendor LANGUAGES CXX)

set(CONST_TARGET_NAME "fetched_vendor")

include_directories(_inc)

file(GLOB SOURCES CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/_src/*.cpp")

string(LENGTH "${CMAKE_SOURCE_DIR}/" SOURCE_PATH_SIZE)
add_definitions(-DSOURCE_PATH_SIZE=${SOURCE_PATH_SIZE})

add_library(${CONST_TARGET_NAME} STATIC ${SOURCES})

target_include_directories(${CONST_TARGET_NAME}
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/_inc
)

target_compile_features(${CONST_TARGET_NAME} PUBLIC cxx_std_17)

