#!/bin/bash
set -euo pipefail

BUILD_DIR=${BUILD_DIR:-build}    # if BUILD_DIR is not set as environment variable, default build directory is "build"
[ -d $BUILD_DIR ] && rm -rf $BUILD_DIR

# -S .                : sets source directory to the current directory
# -B build            : sets build directory to the build folder (creates if it does not exist)
# -G "Unix Makefiles" : forces to use Makefile generator (alternative is Ninja / Visual Studio for WIN / XCode for Mac)
# --build             : starts the build process

cmake -S . -B "${BUILD_DIR}" -G "Unix Makefiles"
cmake --build "${BUILD_DIR}" --parallel
