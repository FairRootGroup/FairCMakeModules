*********
Changelog
*********
.. View rendered on https://fairrootgroup.github.io/FairCMakeModules/latest/changelog.html

Unreleased
==========

Changed
-------

* :command:`find_package2`'s option ``ADD_REQUIREMENTS_OF`` is now a no-op. All
  known requirements are merged by default.

New
---

* In module :module:`FairFindPackage2`

  * List FairCMakeModules as package dependency
  * Macro :command:`find_package2_implicit_dependencies`
  * Function :command:`fair_generate_package_dependencies`

* Module :module:`FairFormattedOutput`

* Module :module:`FairSummary`


**v0.1.0 (beta)** 2021-04-24
============================

New
---

* Module :module:`FairFindPackage2`
