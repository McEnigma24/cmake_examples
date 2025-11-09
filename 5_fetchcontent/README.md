# 5 – FetchContent Populated Dependency

Shows `FetchContent`/`FetchContent_MakeAvailable` while demonstrating `file(GLOB ...)` source discovery:

- dependency declaration mimics a remote Git URL but points locally for an offline demo
- `FetchContent_MakeAvailable` injects the dependency's targets (here `fetched_vendor`) into the build
- both the app and dependency use `_src/_inc`, yet this example uniquely gathers sources via `file(GLOB ... CONFIGURE_DEPENDS ...)`
- linking privately keeps dependency usage internal to `fetch_content_app.exe`

```sh
./build.sh
```

