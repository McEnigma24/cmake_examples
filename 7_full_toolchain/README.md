# 7 – Combined Workflow with Toolchain

Brings together all prior concepts:

- internal libraries: `libs/core` and `libs/analytics`, each using `_src/_inc` with `aux_source_directory`
- manual third-party component: `external/manual_vendor` mirrors the same layout but is excluded from the default build until linked
- automatically populated dependency: `fetched_vendor` reused from example 5 via `FetchContent`
- root target `full_toolchain.exe` gathers sources from `_src`/`_inc` and accumulates dependencies in `ALL_LIBRARIES`
- toolchain preset (`arm-debug`) demonstrates cross-compilation setup

```sh
# Native Ninja build
cmake --preset ninja-debug
cmake --build --preset ninja-debug

# Cross compile example (requires adjusting compilers in toolchains/arm-gcc-toolchain.cmake)
cmake --preset arm-debug
cmake --build --preset arm-debug
```

