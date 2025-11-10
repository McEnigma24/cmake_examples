cmake_minimum_required(VERSION 3.23)

project(MonorepoExample VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

option(BUILD_COMPONENT_A "Build component_a executable" ON)
option(BUILD_COMPONENT_B "Build component_b executable" ON)
option(ENABLE_COMPONENT_TESTS "Enable tests for components" ON)

include(FetchContent)

FetchContent_Declare(
    nlohmann_json
    GIT_REPOSITORY https://github.com/nlohmann/json.git
    GIT_TAG        v3.11.3
)

FetchContent_MakeAvailable(nlohmann_json)

string(LENGTH "${CMAKE_SOURCE_DIR}/" SOURCE_PATH_SIZE)

add_library(project_warnings INTERFACE)
target_compile_options(
    project_warnings
    INTERFACE
        -g
        -Wfatal-errors
        -Werror=uninitialized
        -Werror=init-self
        -Werror=reorder
        -Wdelete-incomplete
)

if(ENABLE_COMPONENT_TESTS)
    FetchContent_Declare(
        googletest
        GIT_REPOSITORY https://github.com/google/googletest.git
        GIT_TAG        release-1.12.1
    )

    FetchContent_MakeAvailable(googletest)
    enable_testing()
endif()

add_subdirectory(lib_shared)

if(BUILD_COMPONENT_A)
    add_subdirectory(component_a)
endif()

if(BUILD_COMPONENT_B)
    add_subdirectory(component_b)
endif()

