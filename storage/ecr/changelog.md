# Changelog

## [Unreleased]
### Added
- Initial ECR repository module implementation
- AES256 encryption enabled by default
- Cross-account access permissions for multiple AWS accounts
- Simplified configuration optimized for pipeline-based scanning
- Comprehensive tagging support

### Changed
- Fixed image tag mutability to MUTABLE
- Disabled image scanning on push (optimized for external tools like Trivy)
- Removed lifecycle policy and custom repository policy support
- Simplified variables to essential configuration only

### Fixed
- N/A