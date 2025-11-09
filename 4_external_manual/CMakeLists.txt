cmake_minimum_required(VERSION 3.20)

# Example: manually vendored dependency that we treat similar to a git submodule.
project(ExternalManualExample LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CONST_TARGET_NAME "manual_vendor_app")

# Because we control the vendor directory, we can add it as a subdirectory. Setting
# EXCLUDE_FROM_ALL avoids building it unless required by another target.
add_subdirectory(external/manual_lib EXCLUDE_FROM_ALL)

include_directories(_inc)

aux_source_directory(_src SOURCES)

string(LENGTH "${CMAKE_SOURCE_DIR}/" SOURCE_PATH_SIZE)
add_definitions(-DSOURCE_PATH_SIZE=${SOURCE_PATH_SIZE})

set(ALL_LIBRARIES ${ALL_LIBRARIES} manual_vendor)

message(WARNING "Building exe with manual vendor dependency")

set(TARGET_NAME "${CONST_TARGET_NAME}.exe")
add_executable(${TARGET_NAME} ${SOURCES})
target_link_libraries(${TARGET_NAME} PUBLIC ${ALL_LIBRARIES})
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

# If the external project had transitive dependencies, we would document them here to avoid surprises.

