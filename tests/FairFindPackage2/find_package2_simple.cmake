################################################################################
#    Copyright (C) 2021 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH    #
#                                                                              #
#              This software is distributed under the terms of the             #
#              GNU Lesser General Public Licence (LGPL) version 3,             #
#                  copied verbatim in the file "LICENSE"                       #
################################################################################

set(pkg FooBar)
find_package2(PRIVATE ${pkg} COMPONENTS comp1 comp2)

cmake_print_variables(${pkg}_FOUND)
cmake_print_variables(${pkg}_PREFIX)
cmake_print_variables(PROJECT_PACKAGE_DEPENDENCIES)

if(NOT ${pkg}_FOUND)
  message(FATAL_ERROR "${pkg} not found")
endif()

if(NOT ${pkg} IN_LIST PROJECT_PACKAGE_DEPENDENCIES)
  message(FATAL_ERROR "${pkg} not contained in PROJECT_PACKAGE_DEPENDENCIES")
endif()


find_package2(PUBLIC FooDep REQUIRED COMPONENTS comp1
              OPTIONAL_COMPONENTS comp2 comp3)
assert_true(FooDep_comp1_FOUND)
assert_true(FooDep_comp2_FOUND)
assert_false(FooDep_comp3_FOUND)
