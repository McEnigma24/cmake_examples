#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR="${ROOT_DIR}/build"

BUILD_TYPE="Debug"
BUILD_COMPONENT_A="ON"
BUILD_COMPONENT_B="ON"
ENABLE_TESTS="ON"
CLEAN=false
GENERATOR=""
BUILD_ARGS=()
CMAKE_ARGS=()

usage() {
    cat <<EOF
Usage: $(basename "$0") [options] [-- <extra-cmake-args>...]

Options:
  -t, --type <Debug|Release>    Set CMAKE_BUILD_TYPE (default: Debug)
  --skip-component-a            Do not build component_a_app
  --skip-component-b            Do not build component_b_app
  --no-tests                    Skip configuring and running tests
  --clean                       Remove the build directory before configuring
  -G, --generator <name>        Explicit CMake generator (e.g. "Ninja")
  --build-arg <value>           Extra argument forwarded to 'cmake --build' (repeatable)
  -h, --help                    Show this help message and exit
  --                           Separate script options from extra CMake arguments
EOF
}

require_cmd() {
    if ! command -v "$1" >/dev/null 2>&1; then
        echo "Error: required command '$1' not found in PATH." >&2
        exit 1
    fi
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        -t|--type)
            [[ $# -lt 2 ]] && { echo "Error: missing value for $1"; usage; exit 1; }
            BUILD_TYPE="$2"
            shift 2
            ;;
        --skip-component-a)
            BUILD_COMPONENT_A="OFF"
            shift
            ;;
        --skip-component-b)
            BUILD_COMPONENT_B="OFF"
            shift
            ;;
        --no-tests)
            ENABLE_TESTS="OFF"
            shift
            ;;
        --clean)
            CLEAN=true
            shift
            ;;
        -G|--generator)
            [[ $# -lt 2 ]] && { echo "Error: missing value for $1"; usage; exit 1; }
            GENERATOR="$2"
            shift 2
            ;;
        --build-arg)
            [[ $# -lt 2 ]] && { echo "Error: missing value for $1"; usage; exit 1; }
            BUILD_ARGS+=("$2")
            shift 2
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        --)
            shift
            CMAKE_ARGS+=("$@")
            break
            ;;
        *)
            CMAKE_ARGS+=("$1")
            shift
            ;;
    esac
done

require_cmd cmake
require_cmd ctest

if [[ "$CLEAN" == true ]]; then
    rm -rf "${BUILD_DIR}"
fi

mkdir -p "${BUILD_DIR}"

configure_args=(
    -S "${ROOT_DIR}"
    -B "${BUILD_DIR}"
    "-DCMAKE_BUILD_TYPE=${BUILD_TYPE}"
    "-DBUILD_COMPONENT_A=${BUILD_COMPONENT_A}"
    "-DBUILD_COMPONENT_B=${BUILD_COMPONENT_B}"
    "-DENABLE_COMPONENT_TESTS=${ENABLE_TESTS}"
)

if [[ -n "${GENERATOR}" ]]; then
    configure_args+=("-G" "${GENERATOR}")
fi

configure_args+=("${CMAKE_ARGS[@]}")

cmake "${configure_args[@]}"

build_cmd=(cmake --build "${BUILD_DIR}")
if [[ ${#BUILD_ARGS[@]} -gt 0 ]]; then
    build_cmd+=("${BUILD_ARGS[@]}")
fi

"${build_cmd[@]}"

if [[ "${ENABLE_TESTS}" == "ON" ]]; then
    ctest --test-dir "${BUILD_DIR}" --output-on-failure
fi

