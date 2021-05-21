################################################################################
#    Copyright (C) 2021 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH    #
#                                                                              #
#              This software is distributed under the terms of the             #
#              GNU Lesser General Public Licence (LGPL) version 3,             #
#                  copied verbatim in the file "LICENSE"                       #
################################################################################

include(TestLibMockMessage)

set(CMAKE_CXX_FLAGS "-DTEST=Debug")
set(CMAKE_CXX_STANDARD 17)

fair_summary_global_cxx_flags_standard()

assert_regex_in_message_lines("STATUS: +GLOBAL CXX FLAGS +${CMAKE_CXX_FLAGS}")
assert_regex_in_message_lines("STATUS: +GLOBAL CXX STANDARD +[Cc][+][+]${CMAKE_CXX_STANDARD}")
