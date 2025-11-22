#!/bin/bash
set -euo pipefail

BUILD_DIR=${BUILD_DIR:-build}    # if BUILD_DIR is not set as environment variable, default build directory is "build"
[ -d $BUILD_DIR ] && rm -rf $BUILD_DIR

# -S .                : sets source directory to the current directory
# -B build            : sets build directory to the build folder (creates if it does not exist)
# --build             : starts the build process

cmake -S . -B "${BUILD_DIR}"
cmake --build "${BUILD_DIR}" --parallel



# alternative #

# [ ! -d $BUILD_DIR ] && mkdir $BUILD_DIR || cd $BUILD_DIR
# cmake ..
# make -j $(nproc)
