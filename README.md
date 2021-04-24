# FairCMakeModules

CMake Modules developed in the context of various FAIR projects

## Installation

```
git clone https://github.com/FairRootGroup/FairCMakeModules
cmake -S FairCMakeModules -B FairCMakeModules_build -DCMAKE_INSTALL_PREFIX=FairCMakeModules_install
cmake --build FairCMakeModules_build --target install
```

## License

```
################################################################################
#    Copyright (C) 2021 GSI Helmholtzzentrum fuer Schwerionenforschung GmbH    #
#                                                                              #
#              This software is distributed under the terms of the             #
#              GNU Lesser General Public Licence (LGPL) version 3,             #
#                  copied verbatim in the file "LICENSE"                       #
################################################################################
```

## Contributing

For comments, questions, and bug reports please [open a github issue](https://github.com/FairRootGroup/FairCMakeModules/issues/new).

For code contributions and bug fixes please create [a github pull request](https://github.com/FairRootGroup/FairCMakeModules/pulls) against the `main` branch. Read our [notes for developers](docs/development.md).
