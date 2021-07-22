################################################################################
#    Copyright (C) 2021 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH    #
#                                                                              #
#              This software is distributed under the terms of the             #
#              GNU Lesser General Public Licence (LGPL) version 3,             #
#                  copied verbatim in the file "LICENSE"                       #
################################################################################

file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/modules)
configure_file(
  modules/FairFindPackage2.cmake.in
  ${CMAKE_CURRENT_BINARY_DIR}/modules/FairFindPackage2.cmake
  @ONLY
)

list(TRANSFORM simple_modules APPEND ".cmake"
     OUTPUT_VARIABLE install_simple_modules)
list(TRANSFORM install_simple_modules PREPEND "modules/")

install(
  FILES
    ${CMAKE_CURRENT_BINARY_DIR}/modules/FairFindPackage2.cmake
    ${install_simple_modules}

  DESTINATION "${PROJECT_INSTALL_MODULESDIR}"
)
