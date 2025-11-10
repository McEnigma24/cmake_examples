#!/bin/bash
set -euo pipefail

BUILD_DIR=${BUILD_DIR:-build}
[ -d $BUILD_DIR ] && rm -rf $BUILD_DIR


BUILD_PRESET="make-debug-test"

git submodule update --init --recursive
cmake --preset "$BUILD_PRESET"
cmake --build --preset "$BUILD_PRESET" --parallel
ctest --test-dir "$BUILD_DIR"
