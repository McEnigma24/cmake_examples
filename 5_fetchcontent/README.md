# 05 – FetchContent Populated Dependency

Shows `FetchContent`/`FetchContent_MakeAvailable`:

- dependency declaration mimics a remote Git URL but points locally for an offline demo
- `FetchContent_MakeAvailable` injects the dependency's targets (here `fetched_vendor`) into the build
- linking privately keeps dependency usage internal to `app_with_fetch`

```sh
./build.sh
```

