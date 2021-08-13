cmake_minimum_required(VERSION 3.20.0)

project(LIB_ASAP)
include(CTest)
enable_testing()
set(CMAKE_CXX_STANDARD 14)
# Source Code
add_subdirectory(libASAP)
add_subdirectory(test)
