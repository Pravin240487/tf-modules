provider "aws" {
  region = "us-east-1"
}

module "ses_domain_identity" {
  source = "./path-to-your-ses-module" # Replace with the correct relative or remote module path

  domain_name                  = "example.com"
  topic_arn                    = "arn:aws:sns:us-east-1:123456789012:ses-notifications"
  notification_type            = ["Bounce", "Complaint", "Delivery"]
  aws_ses_identity_policy_name = "example-ses-policy"
  ses_domain_identity_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ses.amazonaws.com"
        },
        Action   = "SES:SendEmail",
        Resource = "*"
      }
    ]
  })
  zone_id = "Z1D633PJN98FT9" # Optional: For DNS setup if needed
}
