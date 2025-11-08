# Example toolchain file for cross-compiling with an ARM GCC toolchain.
# Fill in paths that match your SDK layout.

set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)

# Point these variables to your cross-compiler binaries.
set(CMAKE_C_COMPILER   /opt/arm/gcc/bin/arm-linux-gnueabihf-gcc)
set(CMAKE_CXX_COMPILER /opt/arm/gcc/bin/arm-linux-gnueabihf-g++)

# Optionally define sysroot and search paths to ensure the correct headers/libraries are used.
set(CMAKE_SYSROOT /opt/arm/sysroot)
set(CMAKE_FIND_ROOT_PATH ${CMAKE_SYSROOT})

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

