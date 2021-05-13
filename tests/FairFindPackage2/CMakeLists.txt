################################################################################
#    Copyright (C) 2021 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH    #
#                                                                              #
#              This software is distributed under the terms of the             #
#              GNU Lesser General Public Licence (LGPL) version 3,             #
#                  copied verbatim in the file "LICENSE"                       #
################################################################################

function(find_package2_mock_pkg pkgname version)
  set(subdir "${pkgname}-${version}")
  file(MAKE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/${subdir}")
  set(PROJECT_NAME "${pkgname}")
  configure_package_config_file(
    "MockPkgConfig.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/${subdir}/${pkgname}Config.cmake"
    INSTALL_DESTINATION "${subdir}"
    PATH_VARS CMAKE_INSTALL_PREFIX
  )
  write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/${subdir}/${pkgname}ConfigVersion.cmake"
    VERSION "${version}"
    COMPATIBILITY AnyNewerVersion
    ARCH_INDEPENDENT)
endfunction()

find_package2_mock_pkg(FooBar 1.2.3)
find_package2_mock_pkg(FooDep 2.7.8)


set(suite "find_package2")
set(test "simple")
set(fqtn "${MODULE}.${suite}.${test}")
add_test(NAME ${fqtn} COMMAND ${CMAKE_COMMAND}
  -D "CMAKE_MODULE_PATH=${PATH};${CMAKE_MODULE_PATH}"
  -D "MODULE=${MODULE}"
  -D "CMAKE_PREFIX_PATH=${CMAKE_CURRENT_BINARY_DIR};${CMAKE_CURRENT_SOURCE_DIR}"
  -P "${CMAKE_CURRENT_SOURCE_DIR}/${suite}_${test}.cmake")

set(suite "fair_generate_package_dependencies")
set(test "simple")
set(fqtn "${MODULE}.${suite}.${test}")
add_test(NAME ${fqtn} COMMAND ${CMAKE_COMMAND}
  -D "CMAKE_MODULE_PATH=${PATH};${CMAKE_MODULE_PATH}"
  -D "MODULE=${MODULE}"
  -D "CMAKE_PREFIX_PATH=${CMAKE_CURRENT_BINARY_DIR};${CMAKE_CURRENT_SOURCE_DIR}"
  -P "${CMAKE_CURRENT_SOURCE_DIR}/${suite}_${test}.cmake")
