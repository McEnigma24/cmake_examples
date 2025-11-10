cmake_minimum_required(VERSION 3.20)
project(InternalLibExample LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CONST_TARGET_NAME "app_4")

include_directories(_core/_inc)
aux_source_directory(_core/_src SOURCES)

# adding all internal libraries
add_subdirectory(_libs/math)
set(ALL_LIBRARIES ${ALL_LIBRARIES} internal_lib_math)

include(C-flags.cmake)



# 1 - json #
include(FetchContent)
FetchContent_Declare(
    json
    GIT_REPOSITORY https://github.com/nlohmann/json.git
    GIT_TAG        master
)
# FetchContent_Populate(json)      # pobiera
FetchContent_MakeAvailable(json)   # pobiera i buduje ==> Populate + add_subdirectory

# could be added to FetchContent_Declare clause to specify dir to download to OTHERWISE it will got to internal Cmake /build/_deps/json-*/
# SOURCE_DIR     ${CMAKE_SOURCE_DIR}/external/json

# list(APPEND ALL_LIBRARIES nlohmann_json::nlohmann_json)
set(ALL_LIBRARIES ${ALL_LIBRARIES} nlohmann_json::nlohmann_json)
include_directories(${json_SOURCE_DIR}/include/nlohmann)

add_executable(${CONST_TARGET_NAME} ${SOURCES})
target_link_libraries(${CONST_TARGET_NAME} PRIVATE ${ALL_LIBRARIES})
target_compile_definitions(${CONST_TARGET_NAME} PRIVATE MY_MACRO) # dodajemy własne makro
