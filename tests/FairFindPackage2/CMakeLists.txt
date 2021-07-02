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

set(pkgset2 "${CMAKE_CURRENT_BINARY_DIR}/pkgset2")
mock_pkg(A 1.0.0 DIR ${pkgset2} DEPS "B:0.5.4")
mock_pkg(B 1.0.0 DIR ${pkgset2})

add_module_test(SUITE "find_package2" TEST "simple"
                PREFIX_PATH ${pkgset1})
add_module_test(SUITE "find_package2" TEST "merge_requirements"
                PREFIX_PATH ${pkgset2})
add_module_test(SUITE "find_package2" TEST "lcp")

add_module_test(SUITE "fair_generate_package_dependencies" TEST "simple"
                PREFIX_PATH ${pkgset1})

add_module_test(SUITE "find_package2_implicit_dependencies" TEST "simple"
                PREFIX_PATH ${pkgset2})
