################################################################################
#    Copyright (C) 2021 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH    #
#                                                                              #
#              This software is distributed under the terms of the             #
#              GNU Lesser General Public Licence (LGPL) version 3,             #
#                  copied verbatim in the file "LICENSE"                       #
################################################################################

include_guard(GLOBAL)
include(CMakePrintHelpers)

function(run_module_tests)
  cmake_parse_arguments(PARSE_ARGV 0 ARGS "" "MODULE;PATH" "")

  if(ARGS_PATH)
    set(path "${ARGS_PATH}")
  else()
    set(path "${CMAKE_SOURCE_DIR}/src/modules")
  endif()

  # generic tests
  set(test "IncludeGuardPresent")
  set(fqtn "${ARGS_MODULE}.${test}")
  add_test(NAME ${fqtn} COMMAND head -20 "${path}/${ARGS_MODULE}.cmake")
  set_property(TEST ${fqtn} PROPERTY PASS_REGULAR_EXPRESSION
               "include_guard\(.*\)")

  set(test "VersionCheckPresent")
  set(fqtn "${ARGS_MODULE}.${test}")
  add_test(NAME ${fqtn} COMMAND ${CMAKE_COMMAND}
           -D "CMAKE_MODULE_PATH=${path}"
           -D "MODULE=${ARGS_MODULE}"
           -D "VERSION=3.0.0"
           -P "${CMAKE_CURRENT_SOURCE_DIR}/include_with_version.cmake")
  set_property(TEST ${fqtn} PROPERTY WILL_FAIL ON)

  set(test "ProjectModeInclude")
  set(fqtn "${ARGS_MODULE}.${test}")
  add_test(NAME ${fqtn} COMMAND
           ${CMAKE_CURRENT_SOURCE_DIR}/include_in_project_mode.sh ${ARGS_MODULE})
  set_property(TEST ${fqtn} APPEND PROPERTY ENVIRONMENT
               "CMAKE_CURRENT_SOURCE_DIR=${CMAKE_CURRENT_SOURCE_DIR}")
  set_property(TEST ${fqtn} APPEND PROPERTY ENVIRONMENT
               "CMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX}")
  set_property(TEST ${fqtn} PROPERTY SKIP_RETURN_CODE 42)

  # custom tests
  if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/${ARGS_MODULE}")
    set(MODULE ${ARGS_MODULE})
    set(PATH ${path})
    add_subdirectory(${ARGS_MODULE})
  endif()
endfunction()


# Test that the variable varname has the expected value
function(assert_var_equal varname expected)
  if(${varname} STREQUAL expected)
    message(TRACE "assert_var_equal(${varname} ${expected}) succeeded")
  else()
    cmake_print_variables(${varname})
    message(SEND_ERROR "... assert_var_equal failed, ${varname} should be: ${expected}")
  endif()
endfunction()
