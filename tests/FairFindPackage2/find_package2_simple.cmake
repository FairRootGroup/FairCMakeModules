#! cmake -P
################################################################################
#    Copyright (C) 2021 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH    #
#                                                                              #
#              This software is distributed under the terms of the             #
#              GNU Lesser General Public Licence (LGPL) version 3,             #
#                  copied verbatim in the file "LICENSE"                       #
################################################################################
cmake_minimum_required(VERSION 3.15...3.20)
include(CMakePrintHelpers)
include(${MODULE})

set(pkg FooBar)
find_package2(PRIVATE ${pkg})

cmake_print_variables(${pkg}_FOUND)
cmake_print_variables(PROJECT_PACKAGE_DEPENDENCIES)

if(NOT ${pkg}_FOUND)
  message(FATAL_ERROR "${pkg} not found")
endif()

if(NOT ${pkg} IN_LIST PROJECT_PACKAGE_DEPENDENCIES)
  message(FATAL_ERROR "${pkg} not contained in PROJECT_PACKAGE_DEPENDENCIES")
endif()
