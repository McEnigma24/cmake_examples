# 04 – Manually Managed External Dependency

Demonstrates vendoring a third-party library (e.g., a git submodule):

- dependency lives in `external/manual_lib`
- `add_subdirectory(... EXCLUDE_FROM_ALL)` keeps it out of the default build graph until linked
- executable links `manual_vendor` privately; if a downstream target needed it, link type would become `PUBLIC`
- comments in `CMakeLists.txt` explain why include directories are propagated

```sh
./build.sh
```

