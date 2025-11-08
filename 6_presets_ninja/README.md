# 06 – CMake Presets with Ninja

Highlights modern preset-based workflows:

- `CMakePresets.json` pins the Ninja generator and standard configure/build directories
- library/executable split keeps helper logic reusable
- dependencies: `presets_demo` links `helpers` privately; consumers do not see its headers

```sh
cmake --preset ninja-debug
cmake --build --preset ninja-debug
```

