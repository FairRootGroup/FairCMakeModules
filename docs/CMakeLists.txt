################################################################################
#    Copyright (C) 2021 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH    #
#                                                                              #
#              This software is distributed under the terms of the             #
#              GNU Lesser General Public Licence (LGPL) version 3,             #
#                  copied verbatim in the file "LICENSE"                       #
################################################################################

configure_file(conf.py.in
  "${CMAKE_CURRENT_BINARY_DIR}/conf.py" @ONLY
)

set(builder html)
add_custom_target(docs
  COMMAND ${SPHINX_EXECUTABLE} -a -E -c "${CMAKE_CURRENT_BINARY_DIR}" -b ${builder}
          ${CMAKE_CURRENT_SOURCE_DIR} "${CMAKE_CURRENT_BINARY_DIR}/${builder}"
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
  COMMENT "Generating documentation"
  VERBATIM
)
