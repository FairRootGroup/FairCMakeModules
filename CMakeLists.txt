################################################################################
# Copyright (C) 2021-2022 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH  #
#                                                                              #
#              This software is distributed under the terms of the             #
#              GNU Lesser General Public Licence (LGPL) version 3,             #
#                  copied verbatim in the file "LICENSE"                       #
################################################################################

cmake_minimum_required(VERSION 3.15 FATAL_ERROR)
cmake_policy(VERSION 3.15...3.23)

project(FairCMakeModules VERSION 1.0.0 LANGUAGES CXX
        HOMEPAGE_URL "https://github.com/FairRootGroup/FairCMakeModules")

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)
include(CTest)
list(PREPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/src/modules")
list(PREPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
include(FairProjectConfig)

fair_get_git_version()
message(STATUS "${PROJECT_NAME} Version ${PROJECT_VERSION} (${PROJECT_GIT_VERSION})")

set(PACKAGE_INSTALL_DESTINATION
  ${CMAKE_INSTALL_DATAROOTDIR}/cmake/${PROJECT_NAME}-${PROJECT_VERSION}
)
string(TOLOWER "${PROJECT_NAME}" PROJECT_NAME_LOWER)
set(PROJECT_INSTALL_DATADIR "${CMAKE_INSTALL_DATAROOTDIR}/${PROJECT_NAME_LOWER}")
set(PROJECT_INSTALL_MODULESDIR "${PROJECT_INSTALL_DATADIR}/modules")

# Modules that are just installed and can be used straight away:
set(simple_modules
    FairFormattedOutput
    FairSummary
    FairProjectConfig
)

add_subdirectory(src)
add_subdirectory(tests)

find_program(SPHINX_EXECUTABLE NAMES sphinx-build)
if(SPHINX_EXECUTABLE)
  add_subdirectory(docs)
endif()

configure_package_config_file(
  "cmake/${PROJECT_NAME}Config.cmake.in"
  "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
  INSTALL_DESTINATION "${PACKAGE_INSTALL_DESTINATION}"
  PATH_VARS CMAKE_INSTALL_PREFIX PROJECT_INSTALL_MODULESDIR
)
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


install(
  FILES
    README.md
    CHANGELOG.rst
  DESTINATION "${CMAKE_INSTALL_DOCDIR}")


set(CPACK_GENERATOR "DEB")
set(CPACK_VERBATIM_VARIABLES TRUE)
set(CPACK_PACKAGE_CONTACT "FairSoft <fairsoft-at-gsi@example.org>")
set(CPACK_DEBIAN_FILE_NAME "DEB-DEFAULT")
set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE "all")
set(CPACK_DEBIAN_PACKAGE_HOMEPAGE "${CMAKE_PROJECT_HOMEPAGE_URL}")
set(CPACK_SOURCE_GENERATOR "TXZ")
set(CPACK_SOURCE_PACKAGE_FILE_NAME "${PROJECT_NAME}-${PROJECT_VERSION}")
set(CPACK_SOURCE_IGNORE_FILES
  \\.git/
  build/
  ".*~$")
include(CPack)
