cmake_minimum_required(VERSION 3.20)
project(InternalLibExample LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CONST_TARGET_NAME "app_3")

include_directories(_core/_inc)
aux_source_directory(_core/_src SOURCES)

# adding all internal libraries
add_subdirectory(_libs/math)

include(C-flags.cmake)



add_executable(${CONST_TARGET_NAME} ${SOURCES})
target_link_libraries(${CONST_TARGET_NAME} PRIVATE internal_lib_math) # teraz ustawiamy, że jeśli ktoś zaincluduje ten target to nie dostanie nic z internal_lib_math