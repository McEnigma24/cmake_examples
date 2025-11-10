#!/bin/bash
set -euo pipefail

BUILD_DIR=${BUILD_DIR:-build}    # if BUILD_DIR is not set as environment variable, default build directory is "build"
[ -d $BUILD_DIR ] && rm -rf $BUILD_DIR

cmake -S . -B "${BUILD_DIR}" -G "Unix Makefiles"
cmake --build "${BUILD_DIR}" --parallel
