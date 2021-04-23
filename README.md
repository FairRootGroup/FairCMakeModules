# FairCMakeModules
CMake Modules developed in the context of various FAIR projects


## Directory Structure

* `public/`: Things that will end up directly in the installed tree
  * `public/modules/`: Directly usable cmake modules.
    Note: Files should be either namespaced as `Fair*` or otherwise be
    unique and not conflict with others.
