cmake_minimum_required(VERSION 3.20)
project(InternalLibExample LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CONST_TARGET_NAME "app_6")

include_directories(_core/_inc)
aux_source_directory(_core/_src SOURCES)

include(C-commands.cmake)
include(C-flags.cmake)
include(C-libs.cmake)
include(C-test.cmake)

add_executable(${CONST_TARGET_NAME} ${SOURCES})
target_link_libraries(${CONST_TARGET_NAME} PRIVATE ${ALL_LIBRARIES})
target_compile_definitions(${CONST_TARGET_NAME} PRIVATE MY_MACRO)
