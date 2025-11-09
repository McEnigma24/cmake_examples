cmake_minimum_required(VERSION 3.20)

project(ComponentA LANGUAGES CXX)

set(CONST_TARGET_NAME "component_a")

include(FetchContent)
FetchContent_Declare(
    shared_lib_source
    SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../lib_shared
)
FetchContent_MakeAvailable(shared_lib_source)

include_directories(_inc)

aux_source_directory(_src SOURCES)

string(LENGTH "${CMAKE_SOURCE_DIR}/" SOURCE_PATH_SIZE)
add_definitions(-DSOURCE_PATH_SIZE=${SOURCE_PATH_SIZE})

set(ALL_LIBRARIES ${ALL_LIBRARIES} shared_lib)

message(WARNING "Building component A executable")

set(MAIN_SOURCE "")
foreach(_src_file ${SOURCES})
    if(_src_file MATCHES "main\\.cpp$")
        set(MAIN_SOURCE ${_src_file})
    endif()
endforeach()
list(FILTER SOURCES EXCLUDE REGEX ".*main\\.cpp")

set(LIB_TARGET_NAME "${CONST_TARGET_NAME}_lib")
add_library(${LIB_TARGET_NAME} STATIC ${SOURCES})
target_include_directories(${LIB_TARGET_NAME}
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}/_inc
)
target_link_libraries(${LIB_TARGET_NAME} PUBLIC shared_lib)

set(TARGET_NAME "${CONST_TARGET_NAME}.exe")
add_executable(${TARGET_NAME} ${MAIN_SOURCE})
target_link_libraries(${TARGET_NAME} PRIVATE ${LIB_TARGET_NAME})
target_compile_definitions(${TARGET_NAME} PRIVATE LINUX BUILD_EXECUTABLE)

