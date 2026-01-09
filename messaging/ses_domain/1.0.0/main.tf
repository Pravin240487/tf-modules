resource "aws_ses_domain_identity" "domain_identity" {
  domain = var.domain_name
}

resource "aws_ses_domain_dkim" "dkim_identity" {
  domain = aws_ses_domain_identity.domain_identity.domain
}

resource "aws_ses_domain_identity_verification" "domain_identity_verification" {
  domain = aws_ses_domain_identity.domain_identity.id
}

resource "aws_ses_identity_policy" "example" {
  identity = aws_ses_domain_identity.domain_identity.id
  name     = var.aws_ses_identity_policy_name
  policy   = var.ses_domain_identity_policy
}

resource "aws_ses_identity_notification_topic" "test" {
  for_each = toset(var.notification_type)

  topic_arn                = var.topic_arn
  notification_type        = each.key
  identity                 = aws_ses_domain_identity.domain_identity.domain
  include_original_headers = true
}
# SES Configuration Set
resource "aws_ses_configuration_set" "this" {
  name = "${var.domain_name_cloudwatch}-config-set"
}
module "ses_cw_iam_policy" {
  source               = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/iampolicy/1.0.0"
  iam_policy_name      = "${var.domain_name_cloudwatch}-config-set-iam-policy"
  iam_policy_name_desc = "policy for cw ses"
  iam_policy_statements = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      }
    ]
  tags = var.tags
}
module "ses_cloudwatch" {
  source        = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/iam-role/1.0.0"
  iam_role_name = "${var.domain_name_cloudwatch}-config-set-iam-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ses.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
  iam_role_policy_attachments = [module.ses_cw_iam_policy.arn]
  tags  = var.tags
}

# SES Event Destination to CloudWatch
resource "aws_ses_event_destination" "cloudwatch" {
  name                   = "${var.domain_name_cloudwatch}-event-destination"
  configuration_set_name = aws_ses_configuration_set.this.name
  enabled                = var.cw_event_dest_enable

  matching_types = var.matching_types

  cloudwatch_destination {
    default_value  = "SES"
    dimension_name = "email-destination"
    value_source   = "messageTag"
  }
}