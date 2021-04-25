#! cmake -P
################################################################################
#    Copyright (C) 2021 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH    #
#                                                                              #
#              This software is distributed under the terms of the             #
#              GNU Lesser General Public Licence (LGPL) version 3,             #
#                  copied verbatim in the file "LICENSE"                       #
################################################################################


include(CMakePrintHelpers)
cmake_print_variables(CMAKE_MODULE_PATH)
cmake_print_variables(MODULE)
cmake_print_variables(VERSION)
set(CMAKE_VERSION ${VERSION})
cmake_print_variables(CMAKE_VERSION)

include(${MODULE})
