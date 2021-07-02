################################################################################
#    Copyright (C) 2021 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH    #
#                                                                              #
#              This software is distributed under the terms of the             #
#              GNU Lesser General Public Licence (LGPL) version 3,             #
#                  copied verbatim in the file "LICENSE"                       #
################################################################################

__find_package2_lcp(OUTVAR actual STRINGS
  "/usr/include"
  "/usr/share/cmake/FooBar-42"
)
assert_var_equal(actual "/usr/")

__find_package2_lcp(OUTVAR actual STRINGS
  "single string"
)
assert_var_equal(actual "single string")

__find_package2_lcp(OUTVAR actual STRINGS
  "/usr/include"
  "/usr/share/cmake/FooBar-42"
  "/usr/lib64"
  "/usr/include/foobar"
)
assert_var_equal(actual "/usr/")

__find_package2_lcp(OUTVAR actual STRINGS
  "/usr/include"
  ""
  "/usr/lib64-NOTFOUND"
  "/usr/include/foobar"
)
assert_var_equal(actual "/usr/include")

__find_package2_lcp(OUTVAR actual STRINGS
  "/usr/include"
  "asdf"
  "/usr/lib64"
  "/usr/include/foobar"
)
assert_var_equal(actual "")
