################################################################################
#    Copyright (C) 2021 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH    #
#                                                                              #
#              This software is distributed under the terms of the             #
#              GNU Lesser General Public Licence (LGPL) version 3,             #
#                  copied verbatim in the file "LICENSE"                       #
################################################################################

function(run_demo demoname)
  add_test(NAME ${demoname}
           COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/run_demo.sh ${demoname})
  set_property(TEST ${demoname} APPEND PROPERTY ENVIRONMENT
               "CMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX}")
  set_property(TEST ${demoname} APPEND PROPERTY ENVIRONMENT
               "CMAKE_CURRENT_SOURCE_DIR=${CMAKE_CURRENT_SOURCE_DIR}")
endfunction()

run_demo(demo1)
