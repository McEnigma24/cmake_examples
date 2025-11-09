cmake_minimum_required(VERSION 3.20)

# Highlights the use of CMake presets and generator selection (Ninja in this case).
project(PresetsNinjaExample LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CONST_TARGET_NAME "presets_ninja")

include_directories(_inc)

aux_source_directory(_src SOURCES)

string(LENGTH "${CMAKE_SOURCE_DIR}/" SOURCE_PATH_SIZE)
add_definitions(-DSOURCE_PATH_SIZE=${SOURCE_PATH_SIZE})

# Separate library sources from executable MAIN.
set(MAIN_SOURCE "")
foreach(_src_file ${SOURCES})
    if(_src_file MATCHES "main\\.cpp$")
        set(MAIN_SOURCE ${_src_file})
    endif()
endforeach()
list(FILTER SOURCES EXCLUDE REGEX ".*main\\.cpp")

set(LIB_TARGET_NAME "${CONST_TARGET_NAME}.lib")
add_library(${LIB_TARGET_NAME} STATIC ${SOURCES})
target_include_directories(${LIB_TARGET_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/_inc)

message(WARNING "Building Ninja preset executable")

set(TARGET_NAME "${CONST_TARGET_NAME}.exe")
add_executable(${TARGET_NAME} ${MAIN_SOURCE})
target_link_libraries(${TARGET_NAME} PRIVATE ${LIB_TARGET_NAME})
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

# We expect this directory to be configured via `cmake --preset ninja-debug` (see CMakePresets.json).
# The preset pins the Ninja generator and build directory, so we do not rely on manual `-G` flags.

