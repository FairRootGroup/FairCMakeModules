#! cmake -P
################################################################################
#    Copyright (C) 2021 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH    #
#                                                                              #
#              This software is distributed under the terms of the             #
#              GNU Lesser General Public Licence (LGPL) version 3,             #
#                  copied verbatim in the file "LICENSE"                       #
################################################################################
cmake_minimum_required(VERSION 3.15...3.20)
set(PROJECT_NAME fair_generate_package_dependencies_simple)
include(CMakePrintHelpers)
include(${MODULE})

find_package2(PRIVATE FooBar)
find_package2(PUBLIC FooDep VERSION 2.5)

fair_generate_package_dependencies()
cmake_print_variables(PACKAGE_DEPENDENCIES)

if(COMMAND cmake_language)
  cmake_language(EVAL CODE "${PACKAGE_DEPENDENCIES}")
  if(NOT ${PROJECT_NAME}_PACKAGE_DEPENDENCIES STREQUAL "FooDep")
    cmake_print_variables(${PROJECT_NAME}_PACKAGE_DEPENDENCIES)
    message(FATAL_ERROR "... should be FooDep")
  endif()
  if(NOT ${PROJECT_NAME}_FooDep_VERSION STREQUAL "2.5")
    cmake_print_variables(${PROJECT_NAME}_FooDep_VERSION)
    message(FATAL_ERROR "... should be 2.5")
  endif()
endif()
