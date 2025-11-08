cmake_minimum_required(VERSION 3.20)

# This project demonstrates the minimal CMake flow: configure + build using Makefiles.
project(BasicMakeExample LANGUAGES CXX)

# Always declare the C++ standard explicitly so downstream users know your expectations.
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# In the simplest layout, we have a single executable built from one translation unit.
add_executable(basic_app src/main.cpp)

# Because this target has no dependencies we don't need target_link_libraries here.
# Generated build system defaults to Make because we will invoke `cmake -G "Unix Makefiles"`.

