cmake_minimum_required(VERSION 3.23)

# Integrates multiple dependency strategies (internal libs, manual vendor, FetchContent) and
# documents cross-compilation via a toolchain file.
project(FullToolchainExample LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CONST_TARGET_NAME "full_toolchain")

include(FetchContent)

FetchContent_Declare(
    fetched_vendor
    SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../5_fetchcontent/external/fetched_vendor
)
FetchContent_MakeAvailable(fetched_vendor)

# Internal reusable components.
add_subdirectory(libs/core)
add_subdirectory(libs/analytics)

# Manually managed external dependency (e.g., git submodule).
add_subdirectory(external/manual_vendor EXCLUDE_FROM_ALL)

include_directories(_inc)

aux_source_directory(_src SOURCES)

string(LENGTH "${CMAKE_SOURCE_DIR}/" SOURCE_PATH_SIZE)
add_definitions(-DSOURCE_PATH_SIZE=${SOURCE_PATH_SIZE})

set(ALL_LIBRARIES ${ALL_LIBRARIES} analytics manual_vendor fetched_vendor)

message(WARNING "Building full toolchain executable")

set(TARGET_NAME "${CONST_TARGET_NAME}.exe")
add_executable(${TARGET_NAME} ${SOURCES})

# Dependency rationale:
# - analytics: domain logic; brings core transitively.
# - manual_vendor: manually vendored third-party features (headers + lib).
# - fetched_vendor: automatically populated via FetchContent to simulate remote dependency.
target_link_libraries(${TARGET_NAME}
    PRIVATE
        ${ALL_LIBRARIES}
)
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

# Cross-compilation: configure using e.g.
#   cmake --preset arm-debug
# This preset points to toolchains/arm-gcc-toolchain.cmake, defining compilers/sysroot.

