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

add_module_test(SUITE "find_package2" TEST "simple")
add_module_test(SUITE "fair_generate_package_dependencies" TEST "simple")
