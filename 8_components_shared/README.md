# 8 – Shared Library + Independent Components

This scenario contains only three self-contained projects: the shared library, `component_a`, and `component_b`.  
Each directory includes its own `CMakeLists.txt`; there is no umbrella build target.

- `lib_shared/` exposes reusable helpers via the `_src/_inc` pattern.
- `component_a/` and `component_b/` both use `FetchContent` to pull in `lib_shared` from a sibling directory and compile their own helper libraries.
- Each component emits an executable (`component_a.exe`, `component_b.exe`).

To build one of the components, run CMake from that directory, for example:

```sh
cd component_a
cmake -S . -B build
cmake --build build
```


