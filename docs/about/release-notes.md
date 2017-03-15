# Release Notes

---

## Upgrading

To upgrade MkDocs to the latest version, use pip:

    pip install -U mkdocs

You can determine your currently installed version using `mkdocs --version`:

    $ mkdocs --version
    mkdocs, version 0.15.2

## Maintenance team

The current and past members of the MkDocs team.

* [@tomchristie](https://github.com/tomchristie/)
* [@d0ugal](https://github.com/d0ugal/)
* [@waylan](https://github.com/waylan/)

## Version 0.16.2 (2017-03-13)

* System root (`/`) is not a valid path for site_dir or docs_dir (#1161)
* Refactor readthedocs theme navigation (#1155 & #1156)
* Add support to dev server to serve custom error pages (#1040)
* Ensure nav.homepage.url is not blank on error pages (#1131)
* Increase livereload dependency to 2.5.1 (#1106)

## Version 0.16.1 (2016-12-22)

* Ensure scrollspy behavior does not affect nav bar (#1094)
* Only "load" a theme when it is explicitly requested by the user (#1105)
