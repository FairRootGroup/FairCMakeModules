################################################################################
#    Copyright (C) 2021 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH    #
#                                                                              #
#              This software is distributed under the terms of the             #
#              GNU Lesser General Public Licence (LGPL) version 3,             #
#                  copied verbatim in the file "LICENSE"                       #
################################################################################

include(TestLibMockMessage)

set(CMAKE_CONFIGURATION_TYPES Debug Release)
set(CMAKE_CXX_FLAGS_DEBUG "-DTEST=Debug")
set(CMAKE_CXX_FLAGS_RELEASE "-DTEST=Release")
set(CMAKE_BUILD_TYPE Release)

fair_summary_build_types()

assert_regex_in_message_lines("STATUS: +Debug +${CMAKE_CXX_FLAGS_DEBUG}")
assert_regex_in_message_lines("[*] +Release +${CMAKE_CXX_FLAGS_RELEASE}")
