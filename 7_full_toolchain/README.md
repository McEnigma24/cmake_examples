# 07 – Combined Workflow with Toolchain

Brings together all prior concepts:

- internal libraries: `core` (base metadata) and `analytics` (depends publicly on `core`)
- manual third-party component: `manual_vendor` lives under `external/`
- automatically populated dependency: `fetched_vendor` via `FetchContent`
- toolchain preset (`arm-debug`) demonstrates cross-compilation setup

```sh
# Native Ninja build
cmake --preset ninja-debug
cmake --build --preset ninja-debug

# Cross compile example (requires adjusting compilers in toolchains/arm-gcc-toolchain.cmake)
cmake --preset arm-debug
cmake --build --preset arm-debug
```

