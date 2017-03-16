# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [1.0.0] - 2017-03-14
### Added
* Tests and fixtures for ALB components using awspec
* S3 bucket policy for logging
* Instructions for testing
* principle_account_id is needed for defining the s3 bucket policy

### Changed
* Moved core module into the alb directory. This means any former modules pointing directly at the previous version in github will be broken if not versioned to the 0.1.0 tag.
* Updated documentation

## [0.1.0] - 2017-03-09
### Added
* Initial release

### Changed
