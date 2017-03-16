# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [1.0.0] - 2017-03-16
### Added
* Tests and fixtures for ALB components using awspec and test kitchen
* S3 log bucket and policy rendering for logging now in place
* root_principle_id added and referenced through a map for s3 bucket policy
* string lists moved to native list types
* default region removed

### Changed
* Restructured project templates to alb dir to add testing. This is a breaking change so upping major version.
* Redundant examples dir removed
* Updated documentation

## [0.1.0] - 2017-03-09
### Added
* Initial release
