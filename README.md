# Progressive CMake Examples

Each subdirectory introduces a new build-system concept while keeping source code trivial.  
Run the provided `build.sh` scripts or the documented `cmake --preset` commands to explore.

1. `01_basic_make` – single executable with the Makefile generator.  
2. `02_multi_source` – multiple translation units managed via `target_sources`.  
3. `03_internal_lib` – internal static library exported to an app.  
4. `04_external_manual` – manually vendored third-party library via `add_subdirectory`.  
5. `05_fetchcontent` – dependency populated automatically using `FetchContent`.  
6. `06_presets_ninja` – preset-based workflow with the Ninja generator.  
7. `07_full_toolchain` – combines internal/external deps, FetchContent, presets, and an example cross-compilation toolchain.

All targets require CMake ≥ 3.20 (3.23 for presets with toolchain). Adjust paths in toolchain files to match your environment before trying the cross-compilation preset.

