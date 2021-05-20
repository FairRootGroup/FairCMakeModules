************
Installation
************

.. toctree::
   :caption: Installation

.. contents::
   :local:


From Source
===========

Download the source code with `Git`_ ::

  git clone https://github.com/FairRootGroup/FairCMakeModules

and install with `CMake`_ ::

  cmake -S FairCMakeModules -B <builddir> -DCMAKE_INSTALL_PREFIX=<installdir>
  cmake --build <builddir> --target install

Replace ``<builddir>`` and ``<installdir>`` with directories of your choice.


macOS
=====

Install `Homebrew for macOS`_ and enable the FairSoft `tap`_ ::

  brew tap fairrootgroup/fairsoft

and continue with ::

  brew install faircmakemodules

Find the ``brew`` package formula `here <https://github.com/FairRootGroup/homebrew-fairsoft/blob/master/Formula/faircmakemodules.rb>`__.


Fedora
======

Add the FairSoft RPM repository for Fedora 34 ::

  sudo dnf install https://alfa-ci.gsi.de/packages/rpm/fedora-34-x86_64/fairsoft-release-dev.rpm

and continue with ::

  sudo dnf install faircmakemodules

Find the RPM package source `here <https://git.gsi.de/SDE/packages/faircmakemodules>`__.


.. _Git: https://git-scm.com/
.. _CMake: https://cmake.org/
.. _Homebrew for macOS: https://brew.sh/
.. _tap: https://docs.brew.sh/Taps
