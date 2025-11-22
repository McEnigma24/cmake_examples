# CMake Cheat Sheet (`cmake_examples`)

https://cppcheatsheet.com/notes/cmake/cmake_basic.html
https://cppcheatsheet.com/notes/cmake/cmake_package.html


- TODO -
https://www.youtube.com/watch?v=JnuqMEC7p9E
add packing & find_package example


## Core Configuration

- `cmake_minimum_required` and `project` define the CMake version and project languages.
- `set(CMAKE_CXX_STANDARD ...)` together with `set(CMAKE_CXX_STANDARD_REQUIRED ON)` enforces a C++ standard globally.
- `set(CMAKE_EXPORT_COMPILE_COMMANDS ON)` produces `compile_commands.json` for tooling (clangd, clang-tidy, etc.).

```4:15:1_basic_cmake/CMakeLists.txt
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
add_executable(${CONST_TARGET_NAME}.exe      ${SOURCES})
add_library(${CONST_TARGET_NAME}_st STATIC   ${SOURCES})
add_library(${CONST_TARGET_NAME}_sh SHARED   ${SOURCES})
```

```5:8:8_components_shared/CMakeLists.txt
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
```

## Sources and Targets

- `aux_source_directory` gathers `.cpp` files from a directory; `include_directories` wires in headers (classic style).
- `add_library(... OBJECT ...)` stores compiled object files without creating an archive.
- `target_sources`, `target_include_directories`, and `target_link_libraries` control propagation of headers/flags/dependencies via `PUBLIC`/`PRIVATE`/`INTERFACE` scopes.
- `add_subdirectory` brings internal modules/libraries (e.g. `lib_shared`, `_libs/math`) into the build.

```9:34:3_internal_lib/_libs/math/CMakeLists.txt
aux_source_directory(_core/_src SOURCES)
add_library(${CONST_TARGET_NAME} OBJECT ${SOURCES})
target_include_directories(${CONST_TARGET_NAME}
    PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/_core/_inc
)
```

```1:26:8_components_shared/lib_shared/CMakeLists.txt
add_library(shared_core STATIC)
target_sources(shared_core PRIVATE src/config.cpp src/math.cpp)
target_include_directories(shared_core PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)
target_link_libraries(shared_core PUBLIC project_warnings nlohmann_json::nlohmann_json)
target_compile_features(shared_core PUBLIC cxx_std_20)
```

## Flags and Warnings

- Helper files such as `C-flags.cmake` bundle compiler flags; `set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ...")` accumulates them.
- Interface libraries like `project_warnings` centralize `target_compile_options`, so you can apply a warning profile to multiple targets.

```1:12:3_internal_lib/C-flags.cmake
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -Wfatal-errors -Werror=uninitialized")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -save-temps")
string(LENGTH "${CMAKE_SOURCE_DIR}/" SOURCE_PATH_SIZE)
add_definitions(-DSOURCE_PATH_SIZE=${SOURCE_PATH_SIZE})
```

```25:35:8_components_shared/CMakeLists.txt
add_library(project_warnings INTERFACE)
target_compile_options(
    project_warnings
    INTERFACE
        -g
        -Wfatal-errors
        -Werror=uninitialized
        -Werror=init-self
        -Werror=reorder
        -Wdelete-incomplete
)
```

## Definitions and Macros

- `add_definitions` pushes global macros (e.g. `SOURCE_PATH_SIZE`); `target_compile_definitions` scopes them per target.
- Scope keywords (`PRIVATE`, `PUBLIC`, `INTERFACE`) govern how definitions propagate to dependent targets.

```52:61:4_fetchcontent/CMakeLists.txt
add_executable(${CONST_TARGET_NAME} ${SOURCES})
target_link_libraries(${CONST_TARGET_NAME} PRIVATE ${ALL_LIBRARIES})
target_compile_definitions(${CONST_TARGET_NAME} PRIVATE MY_MACRO)
```

```23:24:8_components_shared/lib_shared/CMakeLists.txt
target_compile_definitions(shared_core PUBLIC SOURCE_PATH_SIZE=${SOURCE_PATH_SIZE})
```

## FetchContent and External Dependencies

- `include(FetchContent)` plus `FetchContent_Declare` / `FetchContent_MakeAvailable` downloads and wires in CMake-managed dependencies (`nlohmann_json`, `googletest`, etc.).
- Extend helper variables (such as `ALL_LIBRARIES`) and link them into your executables.

```21:58:4_fetchcontent/CMakeLists.txt
include(FetchContent)
FetchContent_Declare(
    json
    GIT_REPOSITORY https://github.com/nlohmann/json.git
    GIT_TAG        master
)
FetchContent_MakeAvailable(json)
set(ALL_LIBRARIES ${ALL_LIBRARIES} nlohmann_json::nlohmann_json)
include_directories(${json_SOURCE_DIR}/include/nlohmann)
```

```37:45:8_components_shared/CMakeLists.txt
if(ENABLE_COMPONENT_TESTS)
    FetchContent_Declare(
        googletest
        GIT_REPOSITORY https://github.com/google/googletest.git
        GIT_TAG        release-1.12.1
    )
    FetchContent_MakeAvailable(googletest)
    enable_testing()
endif()
```

## Testing and CTest

- `option(CTEST_ACTIVE ...)` provides a toggle for tests; `list(FILTER ...)` drops `main.cpp` from the test set.
- `enable_testing`, `include(GoogleTest)`, and `gtest_discover_tests` automate GoogleTest registration.
- `set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)` shows how to override cache variables during configuration.

```22:53:5_gtest/CMakeLists.txt
option(CTEST_ACTIVE "Testing is active" OFF)
if(CTEST_ACTIVE)
    include(FetchContent)
    FetchContent_Declare(
        googletest
        GIT_REPOSITORY https://github.com/google/googletest.git
        GIT_TAG        v1.14.0
    )
    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
    FetchContent_MakeAvailable(googletest)
    set(TEST_SOURCES ${SOURCES})
    list(FILTER TEST_SOURCES EXCLUDE REGEX "/main\\.cpp$")
    aux_source_directory(_test TEST_SOURCES)
    add_executable(${TEST_EXE_NAME} ${TEST_SOURCES})
    target_link_libraries(${TEST_EXE_NAME} PRIVATE gtest_main ${ALL_LIBRARIES})
    enable_testing()
    include(GoogleTest)
    gtest_discover_tests(${TEST_EXE_NAME})
endif()
```

## Presets (`CMakePresets.json`)

- Presets streamline configuration/build (`configurePresets`, `buildPresets`) with inheritance via `inherits`.
- Cache entries override configuration (`CMAKE_BUILD_TYPE`, `CTEST_ACTIVE`), and each preset pins a generator (`Ninja`, `Unix Makefiles`).

```8:58:6_presets/CMakePresets.json
"configurePresets": [
  { "name": "base", "hidden": true, "binaryDir": "${sourceDir}/build/" },
  { "name": "ninja-debug", "inherits": "base", "generator": "Ninja",
    "cacheVariables": { "CMAKE_BUILD_TYPE": "Debug" } },
  { "name": "ninja-debug-test", "inherits": "ninja-debug",
    "cacheVariables": { "CTEST_ACTIVE": "ON" } },
  { "name": "make-release", "inherits": "make-debug",
    "cacheVariables": { "CMAKE_BUILD_TYPE": "Release" } }
]
```

## Toolchain and Cross-Compilation

- A dedicated toolchain file configures compilers (`find_program` + `set(CMAKE_<LANG>_COMPILER ...)`), executable suffixes, and `CMAKE_FIND_ROOT_PATH` policies.
- Environment variables (`MINGW_TRIPLET`, `MINGW_PREFIX`) let you customize the toolchain without editing the file.

```1:41:7_toolchain/toolchains/mingw-w64.cmake
set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_EXECUTABLE_SUFFIX ".exe")
find_program(MINGW_C_COMPILER "${MINGW_TRIPLET}-gcc" REQUIRED)
set(CMAKE_C_COMPILER "${MINGW_C_COMPILER}" CACHE FILEPATH "" FORCE)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
```

## List and String Operations

- `string(LENGTH ...)` computes the base path length and exposes it through a macro.
- `list(FILTER ...)` filters source/test collections.

```12:16:3_internal_lib/C-flags.cmake
string(LENGTH "${CMAKE_SOURCE_DIR}/" SOURCE_PATH_SIZE)
add_definitions(-DSOURCE_PATH_SIZE=${SOURCE_PATH_SIZE})
```

```38:41:5_gtest/CMakeLists.txt
set(TEST_SOURCES ${SOURCES})
list(FILTER TEST_SOURCES EXCLUDE REGEX "/main\\.cpp$")
```

