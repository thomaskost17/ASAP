cmake_minimum_required(3.20.0)

project(LIB_ASAP VERSION 0.0 LANGUAGE C++14)
include(CTest)
enable_testing()

# Source Code
add_subdirectory(libASAP)
add_subdirectory(test)
