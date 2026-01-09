```markdown
# SES Email Module

This module is used to create and manage SES email resources.

## Usage

```terraform
module "ses_email" {
  source = "path/to/module"

  # Required variables
  domain           = "example.com"
  email_address    = "user@example.com"

  # Optional variables
  dkim_enabled     = true
  feedback_enabled = true
  region           = "us-east-1"
}
```

## Inputs

| Name               | Description                               | Type    | Default   | Required |
| ------------------ | ----------------------------------------- | ------- | --------- | -------- |
| domain             | The domain to verify.                     | string  | n/a       | yes      |
| email_address      | The email address to verify.              | string  | n/a       | yes      |
| dkim_enabled       | Enable or disable DKIM.                   | bool    | `true`    | no       |
| feedback_enabled   | Enable or disable feedback notifications. | bool    | `true`    | no       |
| region             | AWS region.                               | string  | `us-east-1` | no       |

## Outputs

| Name               | Description                               |
| ------------------ | ----------------------------------------- |
| verification_token | The SES verification token.               |
| domain_verification_record | The DNS record for domain verification. |

## Providers

*   AWS

## Modules

No modules are used in this module.

## Resources

*   aws\_ses\_domain\_identity
*   aws\_ses\_domain\_dkim
*   aws\_ses\_email_identity
*   aws\_route53\_record (optional, for domain verification)

## Notes

*   Ensure you have the AWS provider configured correctly.
*   Route53 integration is optional but recommended for automatic domain verification.
```