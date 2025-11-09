# 6 – CMake Presets with Ninja

Highlights modern preset-based workflows:

- `CMakePresets.json` pins the Ninja generator and standard configure/build directories
- `_src/_inc` populate both a helper library (`presets_ninja_lib`) and the `presets_ninja.exe` target using `aux_source_directory`
- comments outline how presets remove the need for manual `-G Ninja`

```sh
cmake --preset ninja-debug
cmake --build --preset ninja-debug
```

