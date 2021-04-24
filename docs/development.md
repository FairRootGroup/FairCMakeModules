# Notes for developers

## Source Tree Structure

* [`cmake`](../cmake): Private CMake support files for this package
* [`docs`](../docs): Place for documentation sub-pages
* [`src/modules/`](../src/modules): Modules that are automatically prepended to the `CMAKE_MODULE_PATH`.
  Note: Files should be either namespaced as `Fair*` or otherwise be
  unique and not conflict with others.
* [`tests`](../tests): Everything related to testing. Every test should be declared as a CTest in [`tests/CMakeLists.txt`](../tests/CMakeLists.txt).

## Git

* Commit messages should follow these rules: https://chris.beams.io/posts/git-commit/
* You may add a prefix to the commit header, e.g. `README: Add new section`, or `Find<pkg>: Support new version x.y.z`

## CMake

* Write function and macro names in lower-case letters and parameter keywords in upper-case, e.g. `list(PREPEND mylist newitem)`
* Make sure that anything you use will work in the supported CMake version range (see top-level [`CMakeLists.txt`](../CMakeLists.txt)). If it is not possible/feasible, let's discuss bumping the minimum required version.
