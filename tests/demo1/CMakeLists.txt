cmake_minimum_required(VERSION 3.16)

project(demo1 VERSION 1.2.3 LANGUAGES NONE)
include(CMakePrintHelpers)

find_package(FairCMakeModules 1.0 REQUIRED)
cmake_print_variables(FairCMakeModules_FOUND FairCMakeModules_VERSION)
cmake_print_variables(FairCMakeModules_PREFIX)
cmake_print_variables(CMAKE_MODULE_PATH)
include(FairFindPackage2)
find_package2(PRIVATE Git)
