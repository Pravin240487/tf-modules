provider "aws" {
  region = "us-east-1"
}

module "ses_email_identity" {
  source = "./path-to-your-module" # Replace with actual module path

  emails = [
    "admin@example.com",
    "alerts@example.com"
  ]

  ses_email_identity_policy = [
    jsonencode({
      Version = "2012-10-17",
      Statement = [{
        Effect = "Allow",
        Principal = {
          Service = "ses.amazonaws.com"
        },
        Action   = "SES:SendEmail",
        Resource = "*"
      }]
    }),
    jsonencode({
      Version = "2012-10-17",
      Statement = [{
        Effect = "Allow",
        Principal = {
          Service = "ses.amazonaws.com"
        },
        Action   = "SES:SendRawEmail",
        Resource = "*"
      }]
    })
  ]
}
