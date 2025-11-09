# 4 – Manually Managed External Dependency

Demonstrates vendoring a third-party library (e.g., a git submodule):

- dependency lives in `external/manual_lib`, which also uses `_src/_inc` with `aux_source_directory`
- `add_subdirectory(... EXCLUDE_FROM_ALL)` keeps it out of the default build graph until linked
- executable links `manual_vendor` (accumulated in `ALL_LIBRARIES`) privately; elevate to `PUBLIC` if downstream targets must see it
- `SOURCE_PATH_SIZE` trimming mirrors the same pattern as internal targets
- comments call out why dependencies and include directories are propagated

```sh
./build.sh
```

