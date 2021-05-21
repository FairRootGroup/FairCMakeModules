********************
Notes for developers
********************

.. contents::
   :local:


Source Tree Structure
=====================

``cmake/``
    Private CMake support files for this package
``docs/``
    Place for documentation sub-pages
``src/modules/``
    Modules that are automatically prepended to the
    :cmake:variable:`CMAKE_MODULE_PATH`.

    .. note::

      Files and functions should be either namespaced as `Fair*` or otherwise
      be unique enough to minimize chances of conflicts.
``tests/``
    Everything related to testing. Every test should be declared as a
    CTest in ``tests/CMakeLists.txt``.


Git
===

* Commit messages should follow these rules: https://chris.beams.io/posts/git-commit/
* You may add a prefix to the commit header, e.g.

  * ``README: Add new section``, or
  * ``Find<pkg>: Support new version x.y.z``


CMake
=====

* Write function and macro names in lower-case letters and parameter keywords
  in upper-case, e.g. ``list(PREPEND mylist newitem)``
* Make sure that anything you use will work in the supported CMake version
  range:

  * For project CMake code see the top-level ``CMakeLists.txt``. Bump this
    minimum required version if necessary.
  * For installed modules add the following header (Adapt the version as
    necessary):

.. code-block:: cmake

  if(CMAKE_VERSION VERSION_LESS 3.12)
    message(FATAL_ERROR "Module FairFindPackage2 requires CMake 3.12 or later!")
  endif()

  include_guard(GLOBAL)


Changelog and Releases
======================

* Changelog entries shall be prepared during the pull request process and added
  to the *Unreleased* section.
* On releases:

  1. Bump the version number adhering to `Semantic Versioning`_
  2. Make a version entry in the ``CHANGELOG.rst`` and move entries from the
     *Unreleased* section. The release manager may perform additional changes
     to the prepared entries in an *editorial* role if it improves readibility.
  3. Create a signed and annotated tag like this:
     ``git tag -s -a "v1.2.3" -m "Release"``


.. _`Semantic Versioning`: https://semver.org/spec/v2.0.0.html
