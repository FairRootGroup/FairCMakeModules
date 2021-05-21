################################################################################
# Copyright (C) 2018-2021 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH  #
#                                                                              #
#              This software is distributed under the terms of the             #
#              GNU Lesser General Public Licence (LGPL) version 3,             #
#                  copied verbatim in the file "LICENSE"                       #
################################################################################

if(CMAKE_VERSION VERSION_LESS 3.12)
	message(FATAL_ERROR "Module FairSummary requires CMake 3.12 or later!")
endif()

include_guard(GLOBAL)
include(FairFormattedOutput)

#[=======================================================================[.rst:
***********
FairSummary
***********

.. versionadded:: 0.2.0

Requires CMake 3.12 or later.

Depends on :module:`FairFormattedOutput` (and includes it
automatically).
#]=======================================================================]


#[=======================================================================[.rst:
---------

``fair_summary_global_cxx_flags_standard()``
============================================

.. code-block:: cmake

  fair_summary_global_cxx_flags_standard()

If :variable:`CMAKE_CXX_FLAGS`, or :variable:`CMAKE_CXX_STANDARD` are set,
their values are displayed in a nice tabular way.

#]=======================================================================]
function(fair_summary_global_cxx_flags_standard)
  if(CMAKE_CXX_FLAGS OR CMAKE_CXX_STANDARD)
    message(STATUS "  ")
  endif()
  if(CMAKE_CXX_FLAGS)
    message(STATUS "  ${Cyan}GLOBAL CXX FLAGS${CR}     ${BGreen}${CMAKE_CXX_FLAGS}${CR}")
  endif()
  if(CMAKE_CXX_STANDARD)
    message(STATUS "  ${Cyan}GLOBAL CXX STANDARD${CR}  ${BGreen}c++${CMAKE_CXX_STANDARD}${CR}")
  endif()
endfunction()


#[=======================================================================[.rst:
---------

``fair_summary_build_types()``
==============================

.. code-block:: cmake

  fair_summary_build_types()

Display the available Build Types from
:variable:`CMAKE_CONFIGURATION_TYPES` in a nice tabular way and
mark the type, that the user has chosen.

#]=======================================================================]
function(fair_summary_build_types)
  if(CMAKE_CONFIGURATION_TYPES)
    message(STATUS "  ")
    message(STATUS "  ${Cyan}BUILD TYPE           CXX FLAGS${CR}")
    string(TOUPPER "${CMAKE_BUILD_TYPE}" selected_type)
    foreach(type IN LISTS CMAKE_CONFIGURATION_TYPES)
      string(TOUPPER "${type}" type_upper)
      fair_pad("${type}" 21 " " type_padded)
      if(type_upper STREQUAL selected_type)
        message(STATUS "${BGreen}* ${type_padded}${CMAKE_CXX_FLAGS_${type_upper}}${CR}")
      else()
        message(STATUS "  ${BWhite}${type_padded}${CR}${CMAKE_CXX_FLAGS_${type_upper}}")
      endif()
      unset(type_padded)
      unset(type_upper)
    endforeach()
    message(STATUS "  ")
    message(STATUS "  (Change the build type with ${BMagenta}-DCMAKE_BUILD_TYPE=...${CR})")
  endif()
endfunction()


#[=======================================================================[.rst:
---------

``fair_summary_package_dependencies()``
=======================================

.. code-block:: cmake

  fair_summary_package_dependencies()

:command:`find_package2` keeps track of all the found
packages. This function displays them (including found
version, requested version, and install prefix) in a nice
tabulary way.

The prefix column prints the value of :variable:`<pkgname>_PREFIX`.

#]=======================================================================]
function(fair_summary_package_dependencies)
  if(PROJECT_PACKAGE_DEPENDENCIES)
    message(STATUS "  ")
    message(STATUS "  ${Cyan}DEPENDENCY FOUND     VERSION                   PREFIX${CR}")
    foreach(dep IN LISTS PROJECT_PACKAGE_DEPENDENCIES)
      if(${dep}_VERSION)
        set(version_str "${BGreen}${${dep}_VERSION}${CR}")
      else()
        set(version_str "${BYellow}unknown${CR}")
      endif()
      if(PROJECT_${dep}_VERSION)
        set(version_req_str " (>= ${PROJECT_${dep}_VERSION})")
      endif()
      fair_pad(${dep} 21 " " dep_padded)
      fair_pad("${version_str}${version_req_str}" 26 " " version_padded COLOR)
      set(prefix ${${dep}_PREFIX})

      message(STATUS "  ${BWhite}${dep_padded}${CR}${version_padded}${prefix}")

      unset(version_str)
      unset(version_padded)
      unset(version_req_str)
    endforeach()
  endif()
endfunction()
