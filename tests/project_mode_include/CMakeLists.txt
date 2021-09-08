cmake_minimum_required(VERSION 3.10...3.20)
project(project_mode VERSION 1.2.3 LANGUAGES NONE)
include(CMakePrintHelpers)

find_package(FairCMakeModules 0.2 REQUIRED)
cmake_print_variables(FairCMakeModules_FOUND)
cmake_print_variables(FairCMakeModules_VERSION)
cmake_print_variables(FairCMakeModules_PREFIX)
cmake_print_variables(CMAKE_MODULE_PATH)
cmake_print_variables(MODULE)

include(${MODULE})

if(MODULE STREQUAL FairFindPackage2)
  if(NOT FairCMakeModules IN_LIST PROJECT_PACKAGE_DEPENDENCIES)
    message(FATAL_ERROR "FairCMakeModules missing from PROJECT_PACKAGE_DEPENDENCIES!")
  endif()
  if(NOT PROJECT_FairCMakeModules_VERSION STREQUAL 0.2)
    message(FATAL_ERROR "PROJECT_FairCMakeModules_VERSION"
            " (${PROJECT_FairCMakeModules_VERSION}) should be 0.2")
  endif()
endif()
