################################################################################
#    Copyright (C) 2021 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH    #
#                                                                              #
#              This software is distributed under the terms of the             #
#              GNU Lesser General Public Licence (LGPL) version 3,             #
#                  copied verbatim in the file "LICENSE"                       #
################################################################################

mock_pkg(FooBar 1.2.3)
mock_pkg(FooDep 2.7.8)

add_module_test(SUITE "find_package2" TEST "simple")
add_module_test(SUITE "fair_generate_package_dependencies" TEST "simple")
