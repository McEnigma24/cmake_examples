# Zaawansowane możliwości CPack

## 1. Co można pakować?

### Obecna konfiguracja pakuje:

- ✅ **Executables** - pliki wykonywalne (`RUNTIME`)
- ✅ **Header files** - nagłówki do rozwoju (`FILES`)
- 📝 **Libraries** - biblioteki statyczne/dynamiczne (zakomentowane)
- 📝 **Documentation** - dokumentacja (zakomentowane)
- 📝 **Configuration files** - pliki konfiguracyjne (zakomentowane)

### Przykłady instalacji:

```cmake
# Executables
install(TARGETS app_7
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

# Static libraries (.a)
install(TARGETS mylib
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

# Shared libraries (.so/.dll)
install(TARGETS mylib
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}  # .so on Linux
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}  # .dll on Windows
)

# Header files
install(FILES header.h
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/mylib
)

# Directory (cały katalog)
install(DIRECTORY include/
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
  FILES_MATCHING PATTERN "*.h"
)

# Documentation
install(FILES README.md LICENSE
  DESTINATION ${CMAKE_INSTALL_DOCDIR}
)

# Configuration files
install(FILES config/app.conf
  DESTINATION ${CMAKE_INSTALL_SYSCONFDIR}/app
)
```

---

## 2. Różne generatory pakietów

### TGZ (tar.gz) - Universal

```cmake
set(CPACK_GENERATOR "TGZ")
```

- Działa wszędzie
- Tylko archiwum, bez instalatora

### ZIP - Universal

```cmake
set(CPACK_GENERATOR "ZIP")
```

- Działa wszędzie
- Tylko archiwum, bez instalatora

### DEB (Debian/Ubuntu)

```cmake
set(CPACK_GENERATOR "DEB")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Your Name <email@example.com>")
set(CPACK_DEBIAN_PACKAGE_DEPENDS "libc6 (>= 2.17)")
```

- Instalator dla Debian/Ubuntu
- `dpkg -i package.deb` do instalacji
- Automatycznie zarządza zależnościami

### RPM (RedHat/CentOS/Fedora)

```cmake
set(CPACK_GENERATOR "RPM")
set(CPACK_RPM_PACKAGE_GROUP "Development/Tools")
set(CPACK_RPM_PACKAGE_REQUIRES "glibc >= 2.17")
```

- Instalator dla RedHat-based systemów
- `rpm -i package.rpm` do instalacji

### NSIS (Windows Installer)

```cmake
set(CPACK_GENERATOR "NSIS")
set(CPACK_NSIS_MODIFY_PATH ON)  # Dodaje do PATH
set(CPACK_NSIS_CREATE_ICONS_EXTRA "...")  # Ikony na pulpicie
```

- Instalator Windows (.exe)
- GUI instalator
- Może dodawać do PATH, tworzyć skróty, etc.

### 7Z (7-Zip)

```cmake
set(CPACK_GENERATOR "7Z")
```

- Wysoka kompresja
- Tylko archiwum

---

## 3. Komponenty (Component-based packaging)

Pozwala użytkownikom wybrać, co zainstalować:

```cmake
# Definiuj komponenty
install(TARGETS app_7
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  COMPONENT Runtime
)

install(FILES header.h
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
  COMPONENT Headers
)

# Włącz komponenty w CPack
set(CPACK_COMPONENTS_ALL Runtime Headers)
set(CPACK_COMPONENT_RUNTIME_DISPLAY_NAME "Application Runtime")
set(CPACK_COMPONENT_HEADERS_DISPLAY_NAME "Development Headers")
```

Użytkownik może wybrać:

- Tylko Runtime (binaries)
- Tylko Headers (do rozwoju)
- Oba

---

## 4. Customizacja pakietów

### Nazwa pliku pakietu

```cmake
set(CPACK_PACKAGE_FILE_NAME "${PROJECT_NAME}-${PROJECT_VERSION}-${CMAKE_SYSTEM_NAME}")
# Wynik: app_7-1.0.0-Linux.tar.gz
```

### Opis pakietu

```cmake
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Short description")
set(CPACK_PACKAGE_DESCRIPTION "Long multi-line description")
```

### Licencja i README

```cmake
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_SOURCE_DIR}/LICENSE")
set(CPACK_RESOURCE_FILE_README "${CMAKE_SOURCE_DIR}/README.md")
set(CPACK_RESOURCE_FILE_WELCOME "${CMAKE_SOURCE_DIR}/WELCOME.txt")
```

### Ikony i branding

```cmake
# Windows NSIS
set(CPACK_NSIS_MUI_ICON "${CMAKE_SOURCE_DIR}/icon.ico")
set(CPACK_NSIS_MUI_UNICON "${CMAKE_SOURCE_DIR}/uninstall.ico")

# Linux DEB/RPM
set(CPACK_DEBIAN_PACKAGE_SECTION "utils")
set(CPACK_RPM_PACKAGE_LICENSE "MIT")
```

---

## 5. Przykłady użycia

### Podstawowy pakiet (obecna konfiguracja)

```bash
cmake --build --target package
# Tworzy: app_7-1.0.0-Linux.tar.gz i .zip
```

### Pakiet z komponentami

```bash
cmake --build --target package
# Użytkownik może wybrać komponenty podczas instalacji
```

### Tylko pakiet źródłowy

```bash
cmake --build --target package_source
# Tworzy pakiet z kodem źródłowym
```

### Konkretny generator

```bash
cpack -G DEB
# Tworzy tylko pakiet DEB
```

---

## 6. Struktura pakietu

Po `cmake --build --target package`, pakiet zawiera:

```
app_7-1.0.0-Linux/
├── bin/
│   └── app_7                    # Executable
├── include/
│   └── app_7/
│       ├── util.h               # Headers
│       └── math/
│           └── math.h
├── lib/
│   └── libmylib.a               # Libraries (jeśli są)
├── share/
│   └── doc/
│       └── app_7/
│           └── README.md        # Documentation
└── etc/
    └── app_7/
        └── config.conf          # Configuration files
```

---

## 7. Zaawansowane opcje

### Pre/Post install scripts

```cmake
# Linux DEB/RPM
set(CPACK_DEBIAN_PACKAGE_CONTROL_EXTRA
    "${CMAKE_SOURCE_DIR}/scripts/postinst"
    "${CMAKE_SOURCE_DIR}/scripts/prerm"
)
```

### Custom install commands

```cmake
install(CODE "execute_process(COMMAND ...)")
install(SCRIPT custom_install.cmake)
```

### Exclude files

```cmake
set(CPACK_SOURCE_IGNORE_FILES
    "/.git/"
    "/build/"
    "/.*\\.swp$"
)
```

---

## 8. Przykład pełnej konfiguracji

```cmake
# Executables
install(TARGETS app_7
  RUNTIME DESTINATION bin
  COMPONENT Runtime
)

# Libraries
install(TARGETS mylib
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  COMPONENT Libraries
)

# Headers
install(DIRECTORY include/
  DESTINATION include/${PROJECT_NAME}
  COMPONENT Headers
)

# Documentation
install(FILES README.md LICENSE
  DESTINATION share/doc/${PROJECT_NAME}
  COMPONENT Documentation
)

# CPack configuration
set(CPACK_GENERATOR "TGZ;ZIP;DEB")
set(CPACK_COMPONENTS_ALL Runtime Libraries Headers Documentation)
set(CPACK_PACKAGE_DESCRIPTION "Complete application package")
include(CPack)
```

---

## Podsumowanie

CPack może pakować:

- ✅ Executables
- ✅ Libraries (static/shared)
- ✅ Headers
- ✅ Documentation
- ✅ Configuration files
- ✅ Custom files/directories
- ✅ Z komponentami (użytkownik wybiera)
- ✅ Z różnymi generatorami (TGZ, ZIP, DEB, RPM, NSIS, etc.)

**To nie tylko "binarki w innym miejscu" - to pełny system pakowania!**
