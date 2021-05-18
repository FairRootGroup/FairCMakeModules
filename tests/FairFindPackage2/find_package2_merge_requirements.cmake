################################################################################
#    Copyright (C) 2021 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH    #
#                                                                              #
#              This software is distributed under the terms of the             #
#              GNU Lesser General Public Licence (LGPL) version 3,             #
#                  copied verbatim in the file "LICENSE"                       #
################################################################################

find_package2(PRIVATE A REQUIRED) # depends on B v0.5.4
find_package2(PRIVATE B REQUIRED)

set(A_B_VERSION 2.0) # mock A depending on B v2.0

find_package2(PRIVATE B VERSION 0.8) # expected to fail

assert_false(B_FOUND)
