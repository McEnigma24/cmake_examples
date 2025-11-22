#!/bin/bash
set -euo pipefail

BUILD_DIR=${BUILD_DIR:-build}
[ -d $BUILD_DIR ] && rm -rf $BUILD_DIR


cmake -S . -B "${BUILD_DIR}" -DCTEST_ACTIVE=ON
cmake --build "${BUILD_DIR}" --parallel

# CTest - automatically called by CMake via 'test' target
cmake --build "${BUILD_DIR}" --target test || echo "No test target found - skipping tests (set CTEST_ACTIVE=ON to enable)"



# alternalively #

# ctest --test-dir "${BUILD_DIR}"

# or #

# CTEST_ARGS=""
# CTEST_ARGS="${CTEST_ARGS} --test-dir "${BUILD_DIR}""
# CTEST_ARGS="${CTEST_ARGS} --output-on-failure"       # print only failed tests
# CTEST_ARGS="${CTEST_ARGS} --rerun-failed"            # run only those tests that failed in previous run

# ctest ${CTEST_ARGS}
