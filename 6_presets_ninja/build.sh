#!/usr/bin/env bash
set -euo pipefail

cmake --preset ninja-debug
cmake --build --preset ninja-debug

