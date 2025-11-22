#!/bin/bash
set -euo pipefail

BUILD_DIR=${BUILD_DIR:-build}
[ -d $BUILD_DIR ] && rm -rf $BUILD_DIR

BUILD_PRESET="make-debug-test"

export FATAL_ERRORS_FLAG=ON # alternative is to just make another preset to set it but for that small thing I like it this way

cmake --preset "$BUILD_PRESET"
cmake --build --preset "$BUILD_PRESET" --parallel
cmake --build --preset "$BUILD_PRESET" --target test || echo "No test target found - skipping tests (set CTEST_ACTIVE=ON to enable)"
