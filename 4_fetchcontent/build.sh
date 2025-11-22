#!/bin/bash
set -euo pipefail

BUILD_DIR=${BUILD_DIR:-build}
[ -d $BUILD_DIR ] && rm -rf $BUILD_DIR
[ -d external ] && rm -rf external

cmake -S . -B "${BUILD_DIR}"
cmake --build "${BUILD_DIR}" --parallel
