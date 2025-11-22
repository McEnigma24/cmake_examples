#!/bin/bash
set -euo pipefail

BUILD_DIR=${BUILD_DIR:-build}
rm -rf $BUILD_DIR*/

BUILD_PRESET="make-release-win64"

export FATAL_ERRORS_FLAG=ON

cmake --preset "$BUILD_PRESET"
cmake --build --preset "$BUILD_PRESET" --parallel
# ctest --test-dir "$BUILD_DIR"

# cpack - must be run from build directory
pushd $BUILD_DIR
cpack -G TGZ --config CPackConfig.cmake
popd