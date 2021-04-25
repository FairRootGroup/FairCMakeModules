#! /bin/bash
################################################################################
#    Copyright (C) 2021 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH    #
#                                                                              #
#              This software is distributed under the terms of the             #
#              GNU Lesser General Public Licence (LGPL) version 3,             #
#                  copied verbatim in the file "LICENSE"                       #
################################################################################


set -e

d=${CMAKE_PREFIX_PATH}
if [[ ! -d ${d} ]] || [[ -z "$(ls -A ${d})" ]]; then
  echo "==> Skipping this test because project is not installed"
  exit 42 # see SKIP_RETURN_CODE test property
fi

builddir="include_in_project_mode_$1"
rm -rf ${builddir}
mkdir -p ${builddir}
cmake -S ${CMAKE_CURRENT_SOURCE_DIR}/project_mode_include \
      -B ${builddir} -D MODULE=${1}
