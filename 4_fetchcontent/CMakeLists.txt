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

include(C-commands.cmake)
include(C-flags.cmake)


MESSAGE(STATUS "Downloading external libraries...")

# 1 - json #
include(FetchContent)
FetchContent_Declare(
    json
    GIT_REPOSITORY https://github.com/nlohmann/json.git
    GIT_TAG        master
)
# FetchContent_Populate(json)      # pobiera
FetchContent_MakeAvailable(json)   # pobiera i buduje ==> Populate + add_subdirectory

# if there is no CMakeLists.txt in the repository, we have to compile library manually #

            # include_directories(${ssd1306_SOURCE_DIR})

            # # Dodaj pliki źródłowe ręcznie
            # file(GLOB SSD1306_SOURCES
            #     ${ssd1306_SOURCE_DIR}/*.c
            # )
            #
            # lub
            #
            # aux_source_directory(${ssd1306_SOURCE_DIR} ssd1306_SOURCES)

            # add_library(ssd1306 STATIC ${SSD1306_SOURCES})
            # target_include_directories(ssd1306 PUBLIC ${ssd1306_SOURCE_DIR})

            # set(ALL_LIBRARIES ${ALL_LIBRARIES} ssd1306) # dodajemy do glownego EXE



# could be added to FetchContent_Declare clause to specify dir to download to OTHERWISE it will got to internal Cmake /build/_deps/json-*/
# SOURCE_DIR     ${CMAKE_SOURCE_DIR}/external/json

# list(APPEND ALL_LIBRARIES nlohmann_json::nlohmann_json)
set(ALL_LIBRARIES ${ALL_LIBRARIES} nlohmann_json::nlohmann_json)
include_directories(${json_SOURCE_DIR}/include/nlohmann)

add_executable(${CONST_TARGET_NAME} ${SOURCES})
target_link_libraries(${CONST_TARGET_NAME} PRIVATE ${ALL_LIBRARIES})
target_compile_definitions(${CONST_TARGET_NAME} PRIVATE MY_MACRO) # dodajemy własne makro
