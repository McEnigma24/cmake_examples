cmake_minimum_required(VERSION 3.20)
project(MultiSourceExample LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CONST_TARGET_NAME "app_1")


set(SOURCES
    _core/_src/main.cpp
)




add_executable(${CONST_TARGET_NAME}.exe      ${SOURCES})
add_library(${CONST_TARGET_NAME}_st STATIC   ${SOURCES})
add_library(${CONST_TARGET_NAME}_sh SHARED   ${SOURCES})