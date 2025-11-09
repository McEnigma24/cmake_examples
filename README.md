# Progressive CMake Examples

Each subdirectory introduces a new build-system concept while keeping source code trivial.
Run the provided `build.sh` scripts or the documented `cmake --preset` commands to explore.

1. `1_basic_make` – single executable with the Makefile generator.
2. `2_multi_source` – multiple translation units collected via `aux_source_directory` with the `_src/_inc` layout.
3. `3_internal_lib` – reusable static library consumed by an app, still using the `_src/_inc` split.
4. `4_external_manual` – manually vendored third-party library via `add_subdirectory`, assembled with `aux_source_directory`.
5. `5_fetchcontent` – the only example using `file(GLOB ...)` for sources; demonstrates automatic dependency population via `FetchContent`.
6. `6_presets_ninja` – preset-based Ninja workflow that separates helper library sources from the executable.
7. `7_full_toolchain` – combines internal/external deps, reused FetchContent, presets, and a sample cross-compilation toolchain.
8. `8_components_shared` – standalone directories for a shared library and two sibling components; each project has its own `CMakeLists` and pulls in the shared code via `FetchContent`.

All targets require CMake ≥ 3.20 (≥ 3.23 when presets or toolchains are involved). Adjust toolchain paths and external repository configuration before attempting cross-compilation or remote fetches.

