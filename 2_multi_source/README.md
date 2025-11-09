# 2 – Multiple Sources

Extends the basic project with several translation units while following the `_src/_inc` layout:

- `aux_source_directory` automatically collects implementation files from `_src`
- `include_directories(_inc)` exposes headers so `#include "util.h"` works without verbose paths
- macros compute `SOURCE_PATH_SIZE` to trim compile-time log output

The executable is emitted as `multi_source.exe`.

```sh
./build.sh
```

