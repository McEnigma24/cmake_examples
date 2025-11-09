cmake_minimum_required(VERSION 3.20)

# Adds an internal static library built from a subdirectory.
project(InternalLibExample LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CONST_TARGET_NAME "internal_lib_app")

# We keep reusable code in libs/math with its own CMakeLists.txt.
add_subdirectory(libs/math)

include_directories(_inc)

aux_source_directory(_src SOURCES)

string(LENGTH "${CMAKE_SOURCE_DIR}/" SOURCE_PATH_SIZE)
add_definitions(-DSOURCE_PATH_SIZE=${SOURCE_PATH_SIZE})

message(WARNING "Building exe with internal mathlib")

set(TARGET_NAME "${CONST_TARGET_NAME}.exe")
add_executable(${TARGET_NAME} ${SOURCES})
target_link_libraries(${TARGET_NAME} PRIVATE mathlib)
target_compile_definitions(${TARGET_NAME} PRIVATE LINUX BUILD_EXECUTABLE)

set(_props)
if(DEFINED COMPILE_FLAGS AND NOT COMPILE_FLAGS STREQUAL "")
    list(APPEND _props COMPILE_FLAGS "${COMPILE_FLAGS}")
endif()
if(DEFINED LINK_FLAGS AND NOT LINK_FLAGS STREQUAL "")
    list(APPEND _props LINK_FLAGS "${LINK_FLAGS}")
endif()
if(_props)
    set_target_properties(${TARGET_NAME} PROPERTIES ${_props})
endif()

