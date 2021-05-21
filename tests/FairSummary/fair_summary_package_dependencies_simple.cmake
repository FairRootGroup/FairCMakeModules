################################################################################
#    Copyright (C) 2021 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH    #
#                                                                              #
#              This software is distributed under the terms of the             #
#              GNU Lesser General Public Licence (LGPL) version 3,             #
#                  copied verbatim in the file "LICENSE"                       #
################################################################################

include(FairFindPackage2)
include(TestLibMockMessage)

find_package2(PUBLIC FooBar VERSION 1.1 REQUIRED)
find_package2(PRIVATE FooDep)

fair_summary_package_dependencies()

assert_regex_in_message_lines("STATUS: +FooBar +1.2.3 +[(]>= 1[.]1[)] +[^\n]+/FairSummary/pkgset1")
assert_regex_in_message_lines("STATUS: +FooDep +2.7.8 +[^\n]+/FairSummary/pkgset1")
