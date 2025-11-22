#pragma once

#include <cstdint>
#include <iostream>

// Relative path trimming relies on SOURCE_PATH_SIZE emitted from CMake.
#ifndef SOURCE_PATH_SIZE
#    define SOURCE_PATH_SIZE 0
#endif

#define SHARED_FILENAME ((__FILE__) + SOURCE_PATH_SIZE)
#define var(x)   std::cout << SHARED_FILENAME << ":" << __LINE__ << " - " << #x << " = " << (x) << "\n"
#define varr(x)  std::cout << SHARED_FILENAME << ":" << __LINE__ << " - " << #x << " = " << (x) << " "
#define line(x)  std::cout << SHARED_FILENAME << ":" << __LINE__ << " - " << (x) << "\n"
#define linee(x) std::cout << SHARED_FILENAME << ":" << __LINE__ << " - " << (x) << " "
#define nline    std::cout << "\n"

using u8  = std::uint8_t;
using u16 = std::uint16_t;
using u32 = std::uint32_t;
using u64 = std::uint64_t;

using i8  = std::int8_t;
using i16 = std::int16_t;
using i32 = std::int32_t;
using i64 = std::int64_t;

