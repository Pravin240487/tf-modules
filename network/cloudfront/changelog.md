# Changelog

## [1.0.0] - 2025-07-08

### Added
- Initial version of the CloudFront distribution Terraform module.
- Support for:
  - Default and ordered cache behaviors using dynamic input-based policy resolution.
  - Integration with CloudWatch Logs for access logging (via delivery source/destination setup).
  - Optional support for Origin Access Control (OAC).
- Data sources to dynamically fetch:
  - Cache policies
  - Origin request policies
  - Response headers policies
- Full parameterization for distribution behavior, origin, logging, and security settings.
- Added output variables for:
  - `distribution_id`
  - `distribution_arn`
  - `domain_name`
  - `hosted_zone_id`
  - `status`
  - `last_modified_time`
  - `etag`
  - `in_progress_validation_batches`

### Changed
- N/A

### Fixed
- N/A
