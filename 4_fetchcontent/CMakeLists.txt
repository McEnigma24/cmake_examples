cmake_minimum_required(VERSION 3.20)
project(InternalLibExample LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CONST_TARGET_NAME "app_4")

# adding all includes
include_directories(_core/_inc)

# adding all sources
aux_source_directory(_core/_src SOURCES)

# adding all internal libraries
add_subdirectory(_libs/math)
set(ALL_LIBRARIES ${ALL_LIBRARIES} internal_lib_math)

include(flags.cmake)



# 2 - json #
include(FetchContent)
FetchContent_Declare(
    json
    GIT_REPOSITORY https://github.com/nlohmann/json.git
    GIT_TAG        master
)
FetchContent_Populate(json)

# set(ALL_LIBRARIES ${ALL_LIBRARIES} json)
include_directories(${json_SOURCE_DIR}/include)

# set(ALL_LIBRARIES ${ALL_LIBRARIES} json)
include_directories(${json_SOURCE_DIR}/include)


add_executable(${CONST_TARGET_NAME} ${SOURCES})
target_link_libraries(${CONST_TARGET_NAME} PRIVATE ${ALL_LIBRARIES})
target_compile_definitions(${CONST_TARGET_NAME} PRIVATE MY_MACRO) # dodajemy własne makro







# 1 - googletest #

# include(FetchContent)
# FetchContent_Declare(
#     googletest
#     GIT_REPOSITORY https://github.com/google/googletest.git
#     GIT_TAG        v1.14.0
#     )
# FetchContent_MakeAvailable(googletest)

# Samo włączenie będzie dla następnego przykładu #

# # Włączenie testów
# enable_testing()
# # Dodanie testów
# set(TEST_EXE_NAME "test.texe")
# add_executable(${TEST_EXE_NAME} ${TEST_SOURCES})
# target_link_libraries(${TEST_EXE_NAME} PRIVATE gtest_main ${ALL_LIBRARIES})

# # Rejestracja testów
# include(GoogleTest)
# gtest_discover_tests(${TEST_EXE_NAME})