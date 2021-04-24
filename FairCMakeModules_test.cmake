################################################################################
#    Copyright (C) 2021 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH    #
#                                                                              #
#              This software is distributed under the terms of the             #
#              GNU Lesser General Public Licence (LGPL) version 3,             #
#                  copied verbatim in the file "LICENSE"                       #
################################################################################

set(CTEST_SOURCE_DIRECTORY .)
set(CTEST_BINARY_DIRECTORY build)
set(CTEST_CMAKE_GENERATOR "Unix Makefiles")

ctest_empty_binary_directory("${CTEST_BINARY_DIRECTORY}")
ctest_start(Continuous)

get_filename_component(test_install_prefix "${CTEST_BINARY_DIRECTORY}/install"
                       ABSOLUTE)
list(APPEND options
  "-Wdev"
  "-Werror=dev"
  "-DCMAKE_INSTALL_PREFIX:PATH=${test_install_prefix}"
)
ctest_configure(OPTIONS "${options}")

ctest_build(TARGET install)
ctest_test(RETURN_VALUE _ctest_test_ret_val)

if (_ctest_test_ret_val)
  message(FATAL_ERROR " \n"
          "   /!\\  Some tests failed.")
endif()
