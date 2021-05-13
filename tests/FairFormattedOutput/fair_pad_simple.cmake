#! cmake -P
################################################################################
#    Copyright (C) 2021 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH    #
#                                                                              #
#              This software is distributed under the terms of the             #
#              GNU Lesser General Public Licence (LGPL) version 3,             #
#                  copied verbatim in the file "LICENSE"                       #
################################################################################
cmake_minimum_required(VERSION 3.15...3.20)
include(TestLib)
include(${MODULE})

set(str "123")
fair_pad("${str}" 6 " " out)
message(STATUS "_123456_")
message(STATUS "|${out}|")
assert_var_equal(out "${str}   ")
fair_pad("${str}" 3 " " out)
message(STATUS "_123_")
message(STATUS "|${out}|")
assert_var_equal(out "${str}")
fair_pad("${str}" 2 " " out)
message(STATUS "_123_")
message(STATUS "|${out}|")
assert_var_equal(out "${str}")

set(str "${Red}12345${CR}")
fair_pad("${str}" 10 "." out LEFT COLOR)
message(STATUS "1234567890")
message(STATUS "${out}")
assert_var_equal(out ".....${str}")
