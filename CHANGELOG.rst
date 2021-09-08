*********
Changelog
*********
.. View rendered on https://fairrootgroup.github.io/FairCMakeModules/latest/changelog.html

Unreleased **v1.0.0** 2021-xx-xx
================================

New
---

* :command:`find_package2` auto-detects the install prefix and populates the result in
  :variable:`<pkgname>_PREFIX`. Can be disabled globally via
  :variable:`FAIR_NO_AUTO_DETECT_PREFIX`.
* :command:`find_package2` handles ``OPTIONAL_COMPONENTS``.
  :command:`fair_generate_package_dependencies` generates appropriate
  entries.
* Module :module:`FairProjectConfig`
* The requested version of FairCMakeModules during
  :command:`find_package` will show up in
  :command:`fair_summary_package_dependencies`.


**v0.2.0 (beta)** 2021-05-24
============================

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
