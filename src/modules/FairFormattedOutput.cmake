################################################################################
# Copyright (C) 2018-2021 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH  #
#                                                                              #
#              This software is distributed under the terms of the             #
#              GNU Lesser General Public Licence (LGPL) version 3,             #
#                  copied verbatim in the file "LICENSE"                       #
################################################################################

if(CMAKE_VERSION VERSION_LESS 3.12)
  message(FATAL_ERROR "Module FairFormattedOutput requires CMake 3.12 or later!")
endif()

include_guard(GLOBAL)

#[=======================================================================[.rst:
*******************
FairFormattedOutput
*******************

.. versionadded:: 0.2.0

Requires CMake 3.12 or later.

.. contents::
   :local:

---------

On inclusion
============

Defines variables with `ANSI escape codes`_ useful for coloring logs:

==================== =============
CMake variable       ANSI code
==================== =============
:variable:`CR`       ``ESC[m``
:variable:`CB`       ``ESC[1m``
:variable:`Red`      ``ESC[31m``
:variable:`Green`    ``ESC[32m``
:variable:`Yellow`   ``ESC[33m``
:variable:`Blue`     ``ESC[34m``
:variable:`Magenta`  ``ESC[35m``
:variable:`Cyan`     ``ESC[36m``
:variable:`White`    ``ESC[37m``
:variable:`BRed`     ``ESC[1;31m``
:variable:`BGreen`   ``ESC[1;32m``
:variable:`BYellow`  ``ESC[1;33m``
:variable:`BBlue`    ``ESC[1;34m``
:variable:`BMagenta` ``ESC[1;35m``
:variable:`BCyan`    ``ESC[1;36m``
:variable:`BWhite`   ``ESC[1;37m``
==================== =============

Disable by setting :variable:`DISABLE_COLOR` to true.

.. _`ANSI escape codes`: https://en.wikipedia.org/wiki/ANSI_escape_code#3-bit_and_4-bit

#]=======================================================================]

if(NOT WIN32 AND NOT DISABLE_COLOR)
  string(ASCII 27 Esc)
  set(CR       "${Esc}[m")
  set(CB       "${Esc}[1m")
  set(Red      "${Esc}[31m")
  set(Green    "${Esc}[32m")
  set(Yellow   "${Esc}[33m")
  set(Blue     "${Esc}[34m")
  set(Magenta  "${Esc}[35m")
  set(Cyan     "${Esc}[36m")
  set(White    "${Esc}[37m")
  set(BRed     "${Esc}[1;31m")
  set(BGreen   "${Esc}[1;32m")
  set(BYellow  "${Esc}[1;33m")
  set(BBlue    "${Esc}[1;34m")
  set(BMagenta "${Esc}[1;35m")
  set(BCyan    "${Esc}[1;36m")
  set(BWhite   "${Esc}[1;37m")
endif()

#[=======================================================================[.rst:
---------

``fair_pad()``
===================

.. code-block:: cmake

  fair_pad(<str> <width> <char> <out> [LEFT] [COLOR])

Pad given ``<str>`` to ``<width>`` with ``<char>`` and populate the result in
the variable with name given in ``<out>``. Optionally, pad from the left with
``LEFT`` and filter out ANSI color codes with ``COLOR``.

#]=======================================================================]

function(fair_pad str width char out)
  cmake_parse_arguments(ARGS "LEFT;COLOR" "" "" ${ARGN})
  if(ARGS_COLOR)
    string(ASCII 27 Esc)
    string(REGEX REPLACE "${Esc}\\[[0-9;]*m" "" tmp_str "${str}")
  else()
    set(tmp_str "${str}")
  endif()
  string(LENGTH "${tmp_str}" length)
  math(EXPR padding "${width}-${length}")
  if(padding GREATER 0)
    foreach(i RANGE 1 ${padding})
      if(ARGS_LEFT)
        set(str "${char}${str}")
      else()
        set(str "${str}${char}")
      endif()
    endforeach()
  endif()
  set(${out} ${str} PARENT_SCOPE)
endfunction()
