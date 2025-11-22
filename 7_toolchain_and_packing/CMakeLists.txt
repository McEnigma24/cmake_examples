cmake_minimum_required(VERSION 3.20)
project(app_7 VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CONST_TARGET_NAME "app_7")

include_directories(_core/_inc)
aux_source_directory(_core/_src SOURCES)

# find_program(NVIDIA_SMI_EXECUTABLE nvidia-smi)     # check aby program / pakiet był dostępny w systemie
# find_package(CUDAToolkit REQUIRED)
# find_package(OpenMP REQUIRED)

include(C-commands.cmake)
include(C-flags.cmake)
include(C-libs.cmake)
include(C-test.cmake)

add_executable(${CONST_TARGET_NAME} ${SOURCES})
target_link_libraries(${CONST_TARGET_NAME} PRIVATE ${ALL_LIBRARIES})
target_compile_definitions(${CONST_TARGET_NAME} PRIVATE MY_MACRO)


# Make package at the end -> after defining all targets (or at least after defining target we want to package) #

# CPack configuration
include(GNUInstallDirs)

# Install executable
install(TARGETS ${CONST_TARGET_NAME}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  COMPONENT Runtime
)

# Install libraries (if you have static/shared libraries)
# install(TARGETS internal_lib_math
#   ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}      # Static libraries (.a)
#   LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}      # Shared libraries (.so/.dll)
#   RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}      # DLLs on Windows
#   COMPONENT Libraries
# )

# Install header files
install(FILES _core/_inc/util.h
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}
  COMPONENT Headers
)

# Install library headers
install(FILES _libs/math/_core/_inc/math.h
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}/math
  COMPONENT Headers
)

# Install documentation (example)
# install(FILES README.md LICENSE
#   DESTINATION ${CMAKE_INSTALL_DOCDIR}
#   COMPONENT Documentation
# )

# Install configuration files (example)
# install(FILES config/app.conf
#   DESTINATION ${CMAKE_INSTALL_SYSCONFDIR}/${PROJECT_NAME}
#   COMPONENT Configuration
# )

# CPack settings - must be set before include(CPack)
# Set ALL required CPack variables explicitly
set(CPACK_PACKAGE_NAME "${PROJECT_NAME}")
set(CPACK_PACKAGE_VERSION "${PROJECT_VERSION}")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Application with libraries, headers, and documentation")
set(CPACK_PACKAGE_DESCRIPTION "Full package containing:
- Executable binaries
- Header files for development
- Libraries (static/shared)
- Documentation")
set(CPACK_PACKAGE_VENDOR "${PROJECT_NAME}")
set(CPACK_PACKAGE_CONTACT "support@example.com")

# Generators - choose based on target platform
# TGZ = tar.gz (Unix/Linux)
# ZIP = zip (Windows/Universal)
# DEB = Debian package (Linux)
# RPM = RedHat package (Linux)
# NSIS = Windows installer
# 7Z = 7zip archive
set(CPACK_GENERATOR "TGZ;ZIP")
# set(CPACK_GENERATOR "TGZ;ZIP;DEB;RPM")  # For Linux packages

# Package file name format
set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}-${CMAKE_SYSTEM_NAME}")

# Debian package settings
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "crazyguitar")
set(CPACK_DEBIAN_PACKAGE_DEPENDS "libc6 (>= 2.17)")
set(CPACK_DEBIAN_FILE_NAME DEB-DEFAULT)

# RPM package settings
set(CPACK_RPM_PACKAGE_GROUP "Development/Tools")
set(CPACK_RPM_PACKAGE_REQUIRES "glibc >= 2.17")
set(CPACK_RPM_FILE_NAME RPM-DEFAULT)

# NSIS (Windows installer) settings
set(CPACK_NSIS_PACKAGE_NAME "${PROJECT_NAME}")
set(CPACK_NSIS_DISPLAY_NAME "${PROJECT_NAME} ${PROJECT_VERSION}")
set(CPACK_NSIS_HELP_LINK "https://example.com/help")
set(CPACK_NSIS_URL_INFO_ABOUT "https://example.com")
set(CPACK_NSIS_CONTACT "support@example.com")
set(CPACK_NSIS_MODIFY_PATH ON)  # Add to PATH

# Component-based packaging (optional - allows users to install only what they need)
# set(CPACK_COMPONENTS_ALL Runtime Headers Libraries Documentation)
# set(CPACK_COMPONENT_RUNTIME_DISPLAY_NAME "Application Runtime")
# set(CPACK_COMPONENT_HEADERS_DISPLAY_NAME "Development Headers")
# set(CPACK_COMPONENT_LIBRARIES_DISPLAY_NAME "Libraries")
# set(CPACK_COMPONENT_DOCUMENTATION_DISPLAY_NAME "Documentation")

# CRITICAL: CPack uses CPACK_PROJECT_NAME internally
# This must be set as a normal variable (not CACHE) before include(CPack)
set(CPACK_PROJECT_NAME "${PROJECT_NAME}")

# Debug: print ALL CPack variables to verify they are set
message(STATUS "=== CPack Configuration ===")
message(STATUS "CPACK_PACKAGE_NAME: ${CPACK_PACKAGE_NAME}")
message(STATUS "CPACK_PACKAGE_VERSION: ${CPACK_PACKAGE_VERSION}")
message(STATUS "CPACK_PROJECT_NAME: ${CPACK_PROJECT_NAME}")
message(STATUS "PROJECT_NAME: ${PROJECT_NAME}")
message(STATUS "PROJECT_VERSION: ${PROJECT_VERSION}")
message(STATUS "CPACK_GENERATOR: ${CPACK_GENERATOR}")
message(STATUS "==========================")

include(CPack)
