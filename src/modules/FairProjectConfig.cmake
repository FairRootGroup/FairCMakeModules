################################################################################
# Copyright (C) 2018-2021 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH  #
#                                                                              #
#              This software is distributed under the terms of the             #
#              GNU Lesser General Public Licence (LGPL) version 3,             #
#                  copied verbatim in the file "LICENSE"                       #
################################################################################

if(CMAKE_VERSION VERSION_LESS 3.12)
	message(FATAL_ERROR "Module FairProjectConfig requires CMake 3.12 or later!")
endif()

include_guard(GLOBAL)

#[=======================================================================[.rst:
*****************
FairProjectConfig
*****************

.. versionadded:: 1.0.0

Requires CMake 3.12 or later.

#]=======================================================================]


#[=======================================================================[.rst:
---------

``fair_get_git_version()``
==========================

.. code-block:: cmake

   fair_get_git_version([OUTVAR_PREFIX prefix])

The function checks git attributes of the current tree.
If it can't detect anything useful (becausee Git is not
installed, or because there is no git repository), it will
not touch any output variables at all. 

The ``OUTVAR_PREFIX`` option sets the prefix for created
variables. It defaults to ``"PROJECT"``.

Output variables:

:variable:`<prefix>_GIT_VERSION`
    A version string that is created from the output of
    ``git describe``.

#]=======================================================================]
find_package(Git QUIET)
function(fair_get_git_version)
  cmake_parse_arguments(PARSE_ARGV 0 ARGS "" "OUTVAR_PREFIX" "")

  if(NOT ARGS_OUTVAR_PREFIX)
    set(ARGS_OUTVAR_PREFIX PROJECT)
  endif()

  if(GIT_FOUND AND EXISTS ${CMAKE_SOURCE_DIR}/.git)
    execute_process(COMMAND ${GIT_EXECUTABLE} describe --tags --dirty --match "v*"
      OUTPUT_VARIABLE git_version
      OUTPUT_STRIP_TRAILING_WHITESPACE
      WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    )
    if(git_version)
      string(SUBSTRING "${git_version}" 1 -1 ${ARGS_OUTVAR_PREFIX}_GIT_VERSION)
      set(${ARGS_OUTVAR_PREFIX}_GIT_VERSION
          "${${ARGS_OUTVAR_PREFIX}_GIT_VERSION}" PARENT_SCOPE)
    endif()
  endif()
endfunction()
