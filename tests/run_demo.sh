#! /bin/bash

subdir="$CMAKE_CURRENT_SOURCE_DIR/$1"

[ -d "$subdir" ] || exit 1

set -e

mkdir -p "test_build_$1"
cd "test_build_$1"
cmake "$subdir"
make
