# 3 – Internal Library Split

Key ideas:

- reusable code moved into `libs/math` using `_src/_inc` and `aux_source_directory`
- `add_subdirectory(libs/math)` wires the static library into the root project
- `mathlib` exports its headers via `target_include_directories(... PUBLIC …)` so the app can continue using `#include "math.h"`
- the app follows the same `_src/_inc` pattern, with `internal_lib_app.exe` linking the library privately

```sh
./build.sh
```

