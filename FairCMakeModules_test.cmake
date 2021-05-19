################################################################################
#    Copyright (C) 2021 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH    #
#                                                                              #
#              This software is distributed under the terms of the             #
#              GNU Lesser General Public Licence (LGPL) version 3,             #
#                  copied verbatim in the file "LICENSE"                       #
################################################################################

cmake_minimum_required(VERSION 3.15 FATAL_ERROR)
cmake_policy(VERSION 3.15...3.20)

if(NOT STEPS)
  list(APPEND STEPS clean configure build install test)
endif()

set(CTEST_SOURCE_DIRECTORY .)
set(CTEST_BINARY_DIRECTORY build)
set(CTEST_CMAKE_GENERATOR "Unix Makefiles")
get_filename_component(test_install_prefix "${CTEST_BINARY_DIRECTORY}/install"
                       ABSOLUTE)

if(clean IN_LIST STEPS)
  file(REMOVE_RECURSE ${CTEST_BINARY_DIRECTORY})
  file(REMOVE_RECURSE ${test_install_prefix})
  ctest_start(Continuous)
else()
  ctest_start(Continuous APPEND QUIET)
endif()

if(configure IN_LIST STEPS)
  list(APPEND options
    "-Wdev"
    "-Werror=dev"
    "-DCMAKE_INSTALL_PREFIX:PATH=${test_install_prefix}"
  )
  ctest_configure(OPTIONS "${options}")
endif()

if(build IN_LIST STEPS)
  ctest_build()
endif()

if(install IN_LIST STEPS)
  ctest_build(TARGET install)
endif()

if(test IN_LIST STEPS)
  ctest_test(RETURN_VALUE __ret)
  if(__ret)
    message(FATAL_ERROR "Some tests failed.")
  endif()
endif()

