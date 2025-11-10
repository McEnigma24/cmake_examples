cmake_minimum_required(VERSION 3.20)
project(InternalLibExample LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CONST_TARGET_NAME "app_4")

# adding all includes
include_directories(_core/_inc)

# adding all sources
aux_source_directory(_core/_src SOURCES)

include(C-flags.cmake)
include(C-libs.cmake)


add_executable(${CONST_TARGET_NAME} ${SOURCES})
target_link_libraries(${CONST_TARGET_NAME} PRIVATE ${ALL_LIBRARIES})
target_compile_definitions(${CONST_TARGET_NAME} PRIVATE MY_MACRO) # dodajemy własne makro



option(CTEST_ACTIVE "Testing is active" OFF)  # default value - could be overwritten by provided FLAG

if(CTEST_ACTIVE)
    message(WARNING "TESTING...")

    include(FetchContent)
    FetchContent_Declare(
        googletest
        GIT_REPOSITORY https://github.com/google/googletest.git
        GIT_TAG        v1.14.0  # możesz zmienić tag na nowszy gdy będzie dostępny
    )
    # For Windows: Prevent overriding the parent project's compiler/linker settings
    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
    FetchContent_MakeAvailable(googletest)



    set(TEST_SOURCES ${SOURCES})
    list(FILTER TEST_SOURCES EXCLUDE REGEX "/main\\.cpp$")

    # adding all pure test files
    aux_source_directory(_test TEST_SOURCES)

    set(TEST_EXE_NAME "test.texe")
    add_executable(${TEST_EXE_NAME} ${TEST_SOURCES})
    target_link_libraries(${TEST_EXE_NAME} PRIVATE gtest_main ${ALL_LIBRARIES})
    
    # Rejestracja testów
    enable_testing()
    include(GoogleTest)
    gtest_discover_tests(${TEST_EXE_NAME})
endif()
