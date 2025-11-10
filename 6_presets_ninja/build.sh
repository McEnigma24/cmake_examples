#!/bin/bash
set -euo pipefail

BUILD_DIR=${BUILD_DIR:-build}
[ -d $BUILD_DIR ] && rm -rf $BUILD_DIR

git submodule update --init --recursive
cmake -S . -B "${BUILD_DIR}" -DCTEST_ACTIVE=ON
cmake --build "${BUILD_DIR}" --parallel

ctest --test-dir "${BUILD_DIR}"
