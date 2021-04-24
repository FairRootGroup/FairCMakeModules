# Notes for developers

## Source Tree Structure

* [`cmake`](../cmake): Private CMake support files for this package
* [`docs`](../docs): Place for documentation sub-pages
* [`src/modules/`](../src/modules): Modules that are automatically prepended to the `CMAKE_MODULE_PATH`.
  Note: Files should be either namespaced as `Fair*` or otherwise be
  unique and not conflict with others.
* [`tests`](../tests): Everything related to testing. Every test should be declared as a CTest in [`tests/CMakeLists.txt`](../tests/CMakeLists.txt).
