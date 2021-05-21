################################################################################
#    Copyright (C) 2021 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH    #
#                                                                              #
#              This software is distributed under the terms of the             #
#              GNU Lesser General Public Licence (LGPL) version 3,             #
#                  copied verbatim in the file "LICENSE"                       #
################################################################################

set(pkgset1 "${CMAKE_CURRENT_BINARY_DIR}/pkgset1")
mock_pkg(FooBar 1.2.3 DIR ${pkgset1})
mock_pkg(FooDep 2.7.8 DIR ${pkgset1})

add_module_test(SUITE "fair_summary_global_cxx_flags_standard" TEST "simple")
add_module_test(SUITE "fair_summary_build_types" TEST "simple")
add_module_test(SUITE "fair_summary_package_dependencies" TEST "simple"
                PREFIX_PATH ${pkgset1}
                MODULE_PATH "${CMAKE_BINARY_DIR}/src/modules")
