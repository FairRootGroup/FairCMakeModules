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

# Defines some variables with console color escape sequences
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
