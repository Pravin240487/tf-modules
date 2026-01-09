## [1.0.1] - 2025-12-27

### Changed

- **Breaking Change**: Made `post_confirmation_lambda_arn` optional - can now be set to empty string (`""`) for user pools without Lambda triggers
- Lambda configuration is now conditionally created only when `post_confirmation_lambda_arn` is provided

### Added

- ALB authentication support with optional Cognito User Pool Client
- Cognito User Pool Domain creation for ALB authentication
- CloudWatch Log Group creation with 90-day retention
- Enhanced password policy configuration variables
- Account recovery mechanism configuration
- Token validity configuration (access, ID, and refresh tokens)
- Auto-verified attributes configuration
- Username attributes configuration
- Comprehensive example file with 5 different use cases
- Detailed README with usage examples
- ALB listener rule integration example

### Features

- Support for user pools without Lambda integration
- ALB authentication with OAuth 2.0 flows
- Customizable token expiration settings
- Flexible password policies
- Account recovery via verified email
- CloudWatch logging integration

## [1.0.0] - Initial Release

### Added

- Initial release of Cognito User Pool Terraform module
- Required Lambda post-confirmation trigger
- Basic user pool schema configuration
- Advanced security mode support