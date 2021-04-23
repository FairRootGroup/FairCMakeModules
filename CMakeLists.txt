################################################################################
#    Copyright (C) 2021 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH    #
#                                                                              #
#              This software is distributed under the terms of the             #
#              GNU Lesser General Public Licence (LGPL) version 3,             #
#                  copied verbatim in the file "LICENSE"                       #
################################################################################

cmake_minimum_required(VERSION 3.14 FATAL_ERROR)
cmake_policy(VERSION 3.14...3.20)

project(FairCMakeModules VERSION 1.0.0 LANGUAGES NONE)
message(STATUS "${PROJECT_NAME} Version ${PROJECT_VERSION}")

include(CMakePackageConfigHelpers)

set(PACKAGE_INSTALL_DESTINATION
  share/cmake/${PROJECT_NAME}-${PROJECT_VERSION}
)

add_subdirectory(public)

configure_package_config_file(
  "cmake/${PROJECT_NAME}Config.cmake.in"
  "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
  INSTALL_DESTINATION "${PACKAGE_INSTALL_DESTINATION}"
  PATH_VARS CMAKE_INSTALL_PREFIX PACKAGE_INSTALL_DESTINATION)
write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
  VERSION "${PROJECT_VERSION}"
  COMPATIBILITY AnyNewerVersion
  ARCH_INDEPENDENT)
install(
  FILES
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
  DESTINATION "${PACKAGE_INSTALL_DESTINATION}")
