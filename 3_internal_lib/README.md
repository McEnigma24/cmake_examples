# 03 – Internal Library Split

Key ideas:

- reusable code moved into `libs/math` with its own `CMakeLists.txt`
- `add_subdirectory` wires the static library into the root project
- `target_link_libraries(app_with_math PRIVATE mathlib)` documents the dependency relationship  
  (`PRIVATE` because only this executable needs the math helpers)

```sh
./build.sh
```

