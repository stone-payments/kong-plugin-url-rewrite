# Changelog

All changes made on any release of this project should be commented on high level of this document.

Document model based on [Semantic Versioning](http://semver.org/).
Examples of how to use this _markdown_ cand be found here [Keep a CHANGELOG](http://keepachangelog.com/).

## [1.2.0](https://github.com/stone-payments/kong-plugin-url-rewrite/compare/v1.1.1...v1.2.0) (2022-10-04)


### Features

* Ensures compatibility with kong 3.0 ([06aa948](https://github.com/stone-payments/kong-plugin-url-rewrite/commit/06aa9485701724b122ba571f11546d84192e4cbb))

### [1.1.1](https://github.com/stone-payments/kong-plugin-url-rewrite/compare/v1.1.0...v1.1.1) (2022-03-17)


### Bug Fixes

* Fixes luarocks package download during publish ([ae086cd](https://github.com/stone-payments/kong-plugin-url-rewrite/commit/ae086cd2015bc0b2037251f1be3953a808eb3d3f))

## [1.1.0](https://github.com/stone-payments/kong-plugin-url-rewrite/compare/v1.0.0...v1.1.0) (2022-03-16)


### Features

* Adds service path to upstream URL when it is present ([cafa270](https://github.com/stone-payments/kong-plugin-url-rewrite/commit/cafa270ebab5f585705234d4491a0206ffd811f5))

## [1.0.0](https://github.com/stone-payments/kong-plugin-url-rewrite/tree/v1.0.0) - 2021-12-21
### Feature
- Upgrades plugin to be kong >= 2.6.0 compatible.

## [0.5.1](https://github.com/stone-payments/kong-plugin-url-rewrite/tree/v0.5.1) - 2020-04-01
### Fixed
- [resolveUrlParams function with special character in url](https://dev.azure.com/stonepagamentos/frt-portal/_workitems/edit/132078)

## [0.5.0](https://github.com/stone-payments/kong-plugin-url-rewrite/tree/v0.5.0) - 2020-03-05
### Added
- Support to querystring field.

## [0.4.0](https://github.com/stone-payments/kong-plugin-url-rewrite/tree/v0.4.0) - 2018-12-26
### Added
- Support to parameter replacing when rewriting URL.

## [0.3.0](https://github.com/stone-payments/kong-plugin-url-rewrite/tree/v0.3.0) - 2018-10-30
### Added
- Travis CI and deploy stage.

## [0.2.0](https://github.com/stone-payments/kong-plugin-url-rewrite/tree/v0.2.0) - 2018-05-23
### Changed
- Package name in rockspec.

## [0.1.0](https://github.com/stone-payments/kong-plugin-url-rewrite/tree/v0.1.0) - 2018-04-24
### Added
- First version of the url rewrite plugin.
- VSTS support.
