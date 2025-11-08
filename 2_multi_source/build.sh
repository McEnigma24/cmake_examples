#!/usr/bin/env bash
set -euo pipefail

BUILD_DIR=${BUILD_DIR:-build}
cmake -S . -B "${BUILD_DIR}" -G "Unix Makefiles"
cmake --build "${BUILD_DIR}"

