cmake_minimum_required(VERSION 3.20.0)

project(LIB_ASAP LANGUAGES C CXX VERSION 0.1)
include(CTest)

# Add compiler flags
add_compile_options(-fstack-protector -D_FORTIFY_SOURCE=2 -O2 -Wall)

# Set CPP Language standard
set(CMAKE_CXX_STANDARD 14)

# Find External Packages

# Source Code
add_subdirectory(libASAP)
add_subdirectory(test)
enable_testing()
