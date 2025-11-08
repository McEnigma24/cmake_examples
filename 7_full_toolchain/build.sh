#!/usr/bin/env bash
set -euo pipefail

PRESET=${1:-ninja-debug}
cmake --preset "${PRESET}"
cmake --build --preset "${PRESET}"

