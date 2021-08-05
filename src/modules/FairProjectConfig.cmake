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

   fair_get_git_version([OUTVAR_PREFIX prefix]
                        [TAGS_ONLY] [REQUIRED])

The function checks git attributes of the current tree.
If it can't detect anything useful (becausee Git is not
installed, or because there is no git repository), it will
not touch any output variables at all. 

``OUTVAR_PREFIX``
    This option sets the prefix for created
    variables. It defaults to ``"PROJECT"``.

``TAGS_ONLY``
    This option tells Git to search for tags and use them
    as base for the returned information.
    If this option is not given, Git can also return a
    (shortened) commit hash.
    (Current implementation detail: not passing this option
    will pass ``--always`` to ``git describe``.)

``REQUIRED``
    If no suitable information can be detected (for example
    ``TAGS_ONLY`` is given, but no tags exist, or no git
    repository exists) then a fatal error is raised.

Output variables:

:variable:`<prefix>_GIT_VERSION`
    A version string that is created from the output of
    ``git describe``.

#]=======================================================================]
find_package(Git QUIET)
function(fair_get_git_version)
  cmake_parse_arguments(PARSE_ARGV 0 ARGS
                        "REQUIRED;TAGS_ONLY" "OUTVAR_PREFIX" "")

  if(NOT ARGS_OUTVAR_PREFIX)
    set(ARGS_OUTVAR_PREFIX PROJECT)
  endif()

  if(NOT ARGS_TAGS_ONLY)
    set(git_always "--always")
  endif()

  if(Git_FOUND)
    # TODO use this form once this module requires CMake 3.14
    # execute_process(COMMAND $<TARGET_FILE:Git::Git> describe --tags --dirty ${git_always} --match "v*"
    execute_process(COMMAND ${GIT_EXECUTABLE} describe --tags --dirty ${git_always} --match "v*"
      OUTPUT_VARIABLE git_version
      OUTPUT_STRIP_TRAILING_WHITESPACE
      ERROR_VARIABLE git_error_output
      RESULT_VARIABLE git_result
      WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    )
    if(ARGS_REQUIRED AND (git_error_output OR git_result))
      message(FATAL_ERROR "git describe failed (return value ${git_result}):\n"
              "${git_error_output}")
    endif()
    if(git_version)
      if(git_version MATCHES "^v.*")
        string(SUBSTRING "${git_version}" 1 -1 git_version)
      endif()
      set(${ARGS_OUTVAR_PREFIX}_GIT_VERSION "${git_version}" PARENT_SCOPE)
    endif()
  else()
    if(ARGS_REQUIRED)
      message(FATAL_ERROR "Git not installed")
    endif()
  endif()
endfunction()
