cmake_minimum_required(VERSION 3.20)

# Demonstrates FetchContent, which downloads/configures dependencies during the configure step.
project(FetchContentExample LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CONST_TARGET_NAME "fetch_content_app")

include(FetchContent)

# Real-world usage would fetch from a remote VCS/URL. For an offline-friendly demo we point to a
# local directory, but the API surface is identical.
FetchContent_Declare(
    fetched_vendor
    SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/external/fetched_vendor
    # Alternative (real) usage:
    # GIT_REPOSITORY https://github.com/example/vendor.git
    # GIT_TAG        v1.2.3
)

# Populate + add_subdirectory in one step; creates the target defined by the dependency's CMakeLists.
FetchContent_MakeAvailable(fetched_vendor)

include_directories(_inc)

file(GLOB SOURCES CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/_src/*.cpp")

string(LENGTH "${CMAKE_SOURCE_DIR}/" SOURCE_PATH_SIZE)
add_definitions(-DSOURCE_PATH_SIZE=${SOURCE_PATH_SIZE})

set(ALL_LIBRARIES ${ALL_LIBRARIES} fetched_vendor)

message(WARNING "Building exe with FetchContent dependency")

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

