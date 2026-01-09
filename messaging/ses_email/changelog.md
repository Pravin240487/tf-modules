
---

### 📄 `CHANGELOG.md`

```markdown
# Changelog

## [1.0.0] - 2025-07-18

### Added
- SES email identity creation using `aws_ses_email_identity` with support for multiple emails.
- SES identity policy assignment using `aws_ses_identity_policy` mapped one-to-one with each email.
- Input variables:
  - `emails`
  - `ses_email_identity_policy`
