cmake_minimum_required(VERSION 3.20)
project(InternalLibExample LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CONST_TARGET_NAME "app_7")

include_directories(_core/_inc)
aux_source_directory(_core/_src SOURCES)

find_program(NVIDIA_SMI_EXECUTABLE nvidia-smi)     # aby program był dostępny w systemie

include(C-commands.cmake)
include(C-flags.cmake)
include(C-libs.cmake)
include(C-test.cmake)

add_executable(${CONST_TARGET_NAME} ${SOURCES})
target_link_libraries(${CONST_TARGET_NAME} PRIVATE ${ALL_LIBRARIES})
target_compile_definitions(${CONST_TARGET_NAME} PRIVATE MY_MACRO) # dodajemy własne makro


