
---

### 📄 `CHANGELOG.md`

```markdown
# Changelog

## [1.0.0] - 2025-07-18

### Added
- Created SNS topic with configurable name and delivery policy.
- Enabled optional encryption with either default or customer-managed KMS keys.
- Created support for multiple endpoint subscriptions.
- Added input variables:
  - `name`, `tags`, `protocol`, `endpoint`
  - `enable_sns_encryption`, `use_custom_kms_key`, `sns_kms_key_arn`, `kms_master_key_id`
