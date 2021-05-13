################################################################################
#    Copyright (C) 2021 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH    #
#                                                                              #
#              This software is distributed under the terms of the             #
#              GNU Lesser General Public Licence (LGPL) version 3,             #
#                  copied verbatim in the file "LICENSE"                       #
################################################################################

set(suite "fair_pad")
set(test "simple")
set(fqtn "${MODULE}.${suite}.${test}")
add_test(NAME ${fqtn} COMMAND ${CMAKE_COMMAND}
  -D "CMAKE_MODULE_PATH=${PATH};${CMAKE_MODULE_PATH}"
  -D "MODULE=${MODULE}"
  -D "CMAKE_PREFIX_PATH=${CMAKE_CURRENT_BINARY_DIR};${CMAKE_CURRENT_SOURCE_DIR}"
  -P "${CMAKE_CURRENT_SOURCE_DIR}/${suite}_${test}.cmake")
