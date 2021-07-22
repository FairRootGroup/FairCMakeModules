################################################################################
#    Copyright (C) 2021 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH    #
#                                                                              #
#              This software is distributed under the terms of the             #
#              GNU Lesser General Public Licence (LGPL) version 3,             #
#                  copied verbatim in the file "LICENSE"                       #
################################################################################

if(NOT DOCS_VERSION)
  set(DOCS_VERSION latest)
endif()

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

foreach(module IN LISTS simple_modules)
  if(NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/module/${module}.rst")
    message(FATAL_ERROR "You must document ${module}!

      Create '${CMAKE_CURRENT_SOURCE_DIR}/module/${module}.rst'
      Recommended content:
        .. default-domain:: cmake
        .. cmake-module:: ../../src/modules/${module}.cmake")
  endif()
endforeach()
