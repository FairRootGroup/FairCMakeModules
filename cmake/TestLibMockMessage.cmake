################################################################################
#    Copyright (C) 2021 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH    #
#                                                                              #
#              This software is distributed under the terms of the             #
#              GNU Lesser General Public Licence (LGPL) version 3,             #
#                  copied verbatim in the file "LICENSE"                       #
################################################################################

include_guard(GLOBAL)

# Not allowed in script mode:
# define_property(GLOBAL PROPERTY TEST_MOCK_MESSAGE_BUFFER)

function(message type text)
  _message(${type} ${text})
  set_property(GLOBAL APPEND_STRING PROPERTY TEST_MOCK_MESSAGE_BUFFER
               "${type}:${text}\n")
endfunction()

function(assert_regex_in_message_lines line_regex)
  string(ASCII 27 Esc)
  get_property(buf GLOBAL PROPERTY TEST_MOCK_MESSAGE_BUFFER)
  string(REGEX REPLACE "${Esc}\\[[0-9;]*m" "" buf "${buf}")
  string(REGEX MATCH "${line_regex}" match "${buf}")
  string(LENGTH "${match}" match_len)
  if(match_len EQUAL 0)
    _message(STATUS "regex: [${line_regex}]")
    _message(SEND_ERROR "Not found in messages")
    return()
  endif()
  _message(VERBOSE "regex: [${line_regex}]")
  _message(VERBOSE "match: [${match}]")
  string(REGEX MATCH "\n" match_newline "${match}")
  if(match_newline STREQUAL "\n")
    _message(STATUS "regex: [${line_regex}]")
    _message(STATUS "match: [${match}]")
    _message(SEND_ERROR "Match contains newline")
    return()
  endif()
  _message(VERBOSE "regex: [${line_regex}]")
  _message(VERBOSE "match: [${match}]")
endfunction()
