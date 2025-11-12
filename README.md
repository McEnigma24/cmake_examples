# CMake Cheat Sheet (repo `cmake_examples`)

## Konfiguracja bazowa

- `cmake_minimum_required` i `project` definiują wersję CMake i języki projektu.
- `set(CMAKE_CXX_STANDARD ...)` + `set(CMAKE_CXX_STANDARD_REQUIRED ON)` wymusza standard C++ na wszystkich targetach.
- `set(CMAKE_EXPORT_COMPILE_COMMANDS ON)` generuje `compile_commands.json` dla narzędzi typu clangd.

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

## Źródła i targety

- `aux_source_directory` zbiera pliki `.cpp` z katalogu, a `include_directories` dodaje nagłówki dla starszego stylu.
- `add_library(... OBJECT ...)` pozwala przechować skompilowane obiekty bez tworzenia archiwum.
- `target_sources`, `target_include_directories` oraz `target_link_libraries` z zakresami `PUBLIC`/`PRIVATE`/`INTERFACE` kontrolują propagację nagłówków, flag i zależności.
- `add_subdirectory` włącza moduły/biblioteki wewnętrzne (np. `lib_shared`, `_libs/math`).

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

## Flagi i ostrzeżenia

- Oddzielne pliki (`C-flags.cmake`) budują zestaw flag; `set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ...")` kumuluje ustawienia.
- Interfejsowa biblioteka `project_warnings` przechowuje wspólne `target_compile_options`, co pozwala linkować zestaw ostrzeżeń do wielu targetów.

```1:12:3_internal_lib/C-flags.cmake
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -Wfatal-errors -Werror=uninitialized -Werror=init-self -Werror=reorder -Wdelete-incomplete")
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

## Definicje i makra

- `add_definitions` dodaje globalne makra (tu: `SOURCE_PATH_SIZE`), a `target_compile_definitions` dodaje je selektywnie do targetów.
- Wartości mogą być przekazywane jako `PRIVATE` (tylko lokalnie) lub `PUBLIC` (propagują się do zależnych targetów).

```52:61:4_fetchcontent/CMakeLists.txt
add_executable(${CONST_TARGET_NAME} ${SOURCES})
target_link_libraries(${CONST_TARGET_NAME} PRIVATE ${ALL_LIBRARIES})
target_compile_definitions(${CONST_TARGET_NAME} PRIVATE MY_MACRO)
```

```23:24:8_components_shared/lib_shared/CMakeLists.txt
target_compile_definitions(shared_core PUBLIC SOURCE_PATH_SIZE=${SOURCE_PATH_SIZE})
```

## FetchContent i zależności zewnętrzne

- `include(FetchContent)` + `FetchContent_Declare`/`FetchContent_MakeAvailable` pobiera i automatycznie dodaje projekty CMake (np. `nlohmann_json`, `googletest`).
- Możesz rozszerzać listę bibliotek (np. `ALL_LIBRARIES`) i linkować je do własnych targetów.

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

## Testy i CTest

- `option(CTEST_ACTIVE ...)` pozwala włączać testy przełącznikiem; `list(FILTER ...)` usuwa `main.cpp` z zestawu testowego.
- `enable_testing`, `include(GoogleTest)` i `gtest_discover_tests` automatyzują rejestrację testów GoogleTest.
- `set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)` pokazuje, jak modyfikować cache podczas konfiguracji.

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

## Presety (CMakePresets.json)

- Presety upraszczają konfigurację/build (`configurePresets`, `buildPresets`) i dziedziczenie (`inherits`).
- W cache można nadpisywać flagi (`CMAKE_BUILD_TYPE`, `CTEST_ACTIVE`), a generator wybiera się per preset (`Ninja`, `Unix Makefiles`).

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

## Toolchain i cross-compilacja

- Dedykowany plik toolchain ustawia kompilatory (`find_program` + `set(CMAKE_<LANG>_COMPILER ...)`), suffix binarny i politykę `CMAKE_FIND_ROOT_PATH`.
- Zmienne środowiskowe (`MINGW_TRIPLET`, `MINGW_PREFIX`) pozwalają dopasować konfigurację bez modyfikacji pliku.

```1:41:7_toolchain/toolchains/mingw-w64.cmake
set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_EXECUTABLE_SUFFIX ".exe")
find_program(MINGW_C_COMPILER "${MINGW_TRIPLET}-gcc" REQUIRED)
set(CMAKE_C_COMPILER "${MINGW_C_COMPILER}" CACHE FILEPATH "" FORCE)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
```

## Operacje na listach i łańcuchach

- `string(LENGTH ...)` wylicza długość ścieżki bazowej i udostępnia ją w makrze.
- `list(FILTER ...)` filtruje listy źródeł/testów.

```12:16:3_internal_lib/C-flags.cmake
string(LENGTH "${CMAKE_SOURCE_DIR}/" SOURCE_PATH_SIZE)
add_definitions(-DSOURCE_PATH_SIZE=${SOURCE_PATH_SIZE})
```

```38:41:5_gtest/CMakeLists.txt
set(TEST_SOURCES ${SOURCES})
list(FILTER TEST_SOURCES EXCLUDE REGEX "/main\\.cpp$")
```
