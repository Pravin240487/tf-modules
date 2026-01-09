
---

### 📄 `CHANGELOG.md`

```markdown
# Changelog

## [1.0.0] - 2025-07-18

### Added
- Created SQS queue with configurable parameters for delay, retention, message size, and timeouts.
- Enabled optional SQS-managed or custom KMS encryption.
- Added support for Dead Letter Queue (DLQ).
- Automatically sets redrive policy if DLQ is enabled.
- Input variables include full configurability for encryption and performance.
