################################################################################
#    Copyright (C) 2021 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH    #
#                                                                              #
#              This software is distributed under the terms of the             #
#              GNU Lesser General Public Licence (LGPL) version 3,             #
#                  copied verbatim in the file "LICENSE"                       #
################################################################################

include_guard(GLOBAL)
include(CMakePrintHelpers)

function(add_module_tests)
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


# Test that the variable is true-thy
function(assert_true varname)
  if(${varname})
    message(TRACE "assert_true(${varname}) succeeded")
  else()
    cmake_print_variables(${varname})
    message(SEND_ERROR "... assert_true failed, ${varname} not true-thy")
  endif()
endfunction()


# Test that the variable is false-y
function(assert_false varname)
  if(NOT ${varname})
    message(TRACE "assert_false(${varname}) succeeded")
  else()
    cmake_print_variables(${varname})
    message(SEND_ERROR "... assert_false failed, ${varname} not false-y")
  endif()
endfunction()


#
# add_module_tests(SUITE <suite> TEST <test>
#                  [MODULE <module>]
#                  [MODULE_PATH <module_path>]
#                  [PREFIX_PATH <prefix_path>])
#
# Meant to be called within a CMakeLists.txt added via `add_module_tests`.
#
# `MODULE` defaults to the content of the CMake variable `MODULE` in the calling scope.
# `MODULE_PATH` is prepended to the `CMAKE_MODULE_PATH`.
# `PREFIX_PATH` is prepended to the `CMAKE_PREFIX_PATH`. If not given, it defaults to
# `CMAKE_CURRENT_BINARY_DIR`.
#
function(add_module_test)
  cmake_parse_arguments(PARSE_ARGV 0 ARGS "" "MODULE;SUITE;TEST;PREFIX_PATH" "MODULE_PATH")

  if(ARGS_MODULE)
    set(__module__ ${ARGS_MODULE})
  elseif(DEFINED MODULE)
    set(__module__ ${MODULE})
  else()
    message(SEND_ERROR "No MODULE defined")
    return()
  endif()

  if(NOT ARGS_SUITE)
    message(SEND_ERROR "No SUITE defined")
    return()
  endif()

  if(NOT ARGS_TEST)
    message(SEND_ERROR "No TEST defined")
    return()
  endif()

  set(__fqtn__ "${__module__}.${ARGS_SUITE}.${ARGS_TEST}")

  if(ARGS_MODULE_PATH OR PATH OR CMAKE_MODULE_PATH)
    list(APPEND __module_path__ ${ARGS_MODULE_PATH} ${PATH} ${CMAKE_MODULE_PATH})
    list(JOIN __module_path__ ";" __module_path__)
  endif()

  if(NOT ARGS_PREFIX_PATH)
    list(APPEND __prefix_path__ ${CMAKE_CURRENT_BINARY_DIR} ${CMAKE_PREFIX_PATH})
  else()
    list(APPEND __prefix_path__ ${ARGS_PREFIX_PATH} ${CMAKE_PREFIX_PATH})
  endif()
  list(JOIN __prefix_path__ ";" __prefix_path__)

  add_test(NAME ${__fqtn__} COMMAND ${CMAKE_COMMAND}
    -D "CMAKE_MODULE_PATH=${__module_path__}"
    -D "MODULE=${__module__}"
    -D "CMAKE_PREFIX_PATH=${__prefix_path__}"
    -D "TEST=${CMAKE_CURRENT_SOURCE_DIR}/${ARGS_SUITE}_${ARGS_TEST}.cmake"
    -P "${CMAKE_SOURCE_DIR}/tests/test_module.cmake"
  )
endfunction()

#
# mock_pkg(<pkgname> <version>
#          [DIR <directory>])
#
# DIR is expecting an absolute directory path to generate the mock pkg in. If
# it is not given, it defaults to `CMAKE_CURRENT_BINARY_DIR`
#
function(mock_pkg pkgname version)
  cmake_parse_arguments(PARSE_ARGV 2 ARGS "" "DIR" "")

  if(ARGS_DIR)
    set(__dir__ ${ARGS_DIR})
  else()
    set(__dir__ ${CMAKE_CURRENT_BINARY_DIR})
  endif()

  set(__pkgdir__ "${__dir__}/${pkgname}-${version}")
  file(MAKE_DIRECTORY ${__pkgdir__})

  set(PROJECT_NAME "${pkgname}")
  configure_package_config_file(
    "${CMAKE_SOURCE_DIR}/tests/MockPkgConfig.cmake.in"
    "${__pkgdir__}/${pkgname}Config.cmake"
    INSTALL_DESTINATION "${__pkgdir__}"
    PATH_VARS CMAKE_INSTALL_PREFIX
  )
  write_basic_package_version_file(
    "${__pkgdir__}/${pkgname}ConfigVersion.cmake"
    VERSION "${version}"
    COMPATIBILITY AnyNewerVersion
    ARCH_INDEPENDENT
  )
endfunction()

