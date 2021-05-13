################################################################################
#    Copyright (C) 2021 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH    #
#                                                                              #
#              This software is distributed under the terms of the             #
#              GNU Lesser General Public Licence (LGPL) version 3,             #
#                  copied verbatim in the file "LICENSE"                       #
################################################################################

include(TestLib)

run_module_tests(MODULE FairFindPackage2 PATH "${CMAKE_BINARY_DIR}/src/modules")
run_module_tests(MODULE FairFormattedOutput)
