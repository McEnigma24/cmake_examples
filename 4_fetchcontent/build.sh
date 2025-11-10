#!/bin/bash
set -euo pipefail

BUILD_DIR=${BUILD_DIR:-build}
[ -d $BUILD_DIR ] && rm -rf $BUILD_DIR
[ -d external ] && rm -rf external

git submodule update --init --recursive           # making sure every submodule has its dependencies checked out
cmake -S . -B "${BUILD_DIR}"
cmake --build "${BUILD_DIR}" --parallel
