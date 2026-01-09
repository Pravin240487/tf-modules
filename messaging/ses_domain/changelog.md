# Changelog

## [1.0.0] - 2025-07-18
### Added
- Created SES domain identity using `aws_ses_domain_identity`.
- Enabled DKIM signing via `aws_ses_domain_dkim`.
- Added SES domain verification resource `aws_ses_domain_identity_verification`.
- Attached identity policy using `aws_ses_identity_policy`.
- Configured notification topics for Bounce, Complaint, and Delivery using `aws_ses_identity_notification_topic`.
- Defined outputs for:
  - SES domain identity ARN
  - DKIM tokens
  - Domain verification status
- Introduced variables:
  - `domain_name`
  - `topic_arn`
  - `notification_type` (default: `["Bounce", "Complaint", "Delivery"]`)
  - `ses_domain_identity_policy`
  - `aws_ses_identity_policy_name`
  - `zone_id` (optional)

