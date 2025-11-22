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
target_compile_definitions(${CONST_TARGET_NAME} PRIVATE MY_MACRO) # dodajemy własne makro

# CPack configuration
include(GNUInstallDirs)

install(TARGETS ${CONST_TARGET_NAME}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

# Install header files if needed
# install(FILES _core/_inc/util.h DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

# CPack settings - must be set before include(CPack)
# Set ALL required CPack variables explicitly
# CPack requires these to be set as normal variables (not CACHE) before include(CPack)
set(CPACK_PACKAGE_NAME "${PROJECT_NAME}")
set(CPACK_PACKAGE_VERSION "${PROJECT_VERSION}")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "packed_app_7")
set(CPACK_PACKAGE_VENDOR "${PROJECT_NAME}")
set(CPACK_GENERATOR "TGZ;ZIP")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "crazyguitar")

# CRITICAL: CPack uses CPACK_PROJECT_NAME internally
# This must be set as a normal variable (not CACHE) before include(CPack)
set(CPACK_PROJECT_NAME "${PROJECT_NAME}")

# Also set in parent scope to ensure it's available when cpack is run
set(CPACK_PROJECT_NAME "${PROJECT_NAME}" PARENT_SCOPE)

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
