cmake_minimum_required(VERSION 3.20)
project(MultiSourceExample LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CONST_TARGET_NAME "app_2")

# adding all includes
include_directories(_core/_inc)

# adding all sources
aux_source_directory(_core/_src SOURCES)

include(C-commands.cmake)

string(LENGTH "${CMAKE_SOURCE_DIR}/" SOURCE_PATH_SIZE)
add_definitions(-DSOURCE_PATH_SIZE=${SOURCE_PATH_SIZE})

add_executable(${CONST_TARGET_NAME}.exe      ${SOURCES})
add_library(${CONST_TARGET_NAME}_st STATIC   ${SOURCES})
add_library(${CONST_TARGET_NAME}_sh SHARED   ${SOURCES})
