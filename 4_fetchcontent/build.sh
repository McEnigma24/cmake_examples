#!/bin/bash
set -euo pipefail

BUILD_DIR=${BUILD_DIR:-build}    # if BUILD_DIR is not set as environment variable, default build directory is "build"
[ -d $BUILD_DIR ] && rm -rf $BUILD_DIR
[ -d external ] && rm -rf external

git submodule update --init --recursive           # making sure every submodule has its dependencies checked out
cmake -S . -B "${BUILD_DIR}" -G "Unix Makefiles"
cmake --build "${BUILD_DIR}" --parallel

