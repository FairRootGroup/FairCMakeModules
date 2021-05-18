################################################################################
#    Copyright (C) 2021 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH    #
#                                                                              #
#              This software is distributed under the terms of the             #
#              GNU Lesser General Public Licence (LGPL) version 3,             #
#                  copied verbatim in the file "LICENSE"                       #
################################################################################

find_package2(PRIVATE A REQUIRED) # depends on B

assert_false(B_FOUND)

find_package2_implicit_dependencies()

assert_true(B_FOUND)
