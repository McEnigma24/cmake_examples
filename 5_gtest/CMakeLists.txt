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


