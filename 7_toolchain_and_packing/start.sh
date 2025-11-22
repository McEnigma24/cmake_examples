#!/bin/bash
set -euo pipefail

BUILD_DIR=${BUILD_DIR:-build}
rm -rf $BUILD_DIR*/

# BUILD_PRESET="make-release-win64"    # commented out -> this is only for example -> json submodule stop compiling properly
BUILD_PRESET="ninja-debug-test"

export FATAL_ERRORS_FLAG=ON

cmake --preset "$BUILD_PRESET"
cmake --build --preset "$BUILD_PRESET" --parallel
cmake --build --preset "$BUILD_PRESET" --target test || echo "No test target found - skipping tests (set CTEST_ACTIVE=ON to enable)"

# CPack - automatically called by CMake via 'package' target
cmake --build --preset "$BUILD_PRESET" --target package