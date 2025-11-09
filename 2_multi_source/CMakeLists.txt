cmake_minimum_required(VERSION 3.20)

# Demonstrates aggregating multiple translation units using aux_source_directory.
project(MultiSourceExample LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CONST_TARGET_NAME "multi_source")

include_directories(_inc)

aux_source_directory(_src SOURCES)

# MACRO FOR LOGS - don't show the whole realpath to file
string(LENGTH "${CMAKE_SOURCE_DIR}/" SOURCE_PATH_SIZE)
add_definitions(-DSOURCE_PATH_SIZE=${SOURCE_PATH_SIZE})

set(ALL_LIBRARIES ${ALL_LIBRARIES})

message(WARNING "Building exe")

set(TARGET_NAME "${CONST_TARGET_NAME}.exe")
add_executable(${TARGET_NAME} ${SOURCES})
target_compile_definitions(${TARGET_NAME} PRIVATE LINUX BUILD_EXECUTABLE)

# Only set properties if custom flags are provided to avoid malformed property lists.
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

target_link_libraries(${TARGET_NAME} PUBLIC ${ALL_LIBRARIES})

