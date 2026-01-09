resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = merge(
    {
      Name = var.vpc_name,
    },
    var.tags
  )
}

resource "aws_default_security_group" "this" {
  vpc_id                 = aws_vpc.this.id
  revoke_rules_on_delete = true
  tags = merge(
    {
      Name = "${var.vpc_name}-default-sg",
    },
    var.tags
  )
}

resource "aws_flow_log" "this" {
  count = var.flow_log_enabled ? 1 : 0

  iam_role_arn    = module.vpc_cloudwatch_iam_role[count.index].arn
  log_destination = module.vpc_cloudwatch_log_group[count.index].arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.this.id
  tags = merge(
    {
      Name = "${var.vpc_name}-flow-log",
    },
    var.tags
  )
}

module "vpc_cloudwatch_log_group" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//monitoring/cloudwatch/1.0.0"

  count = var.flow_log_enabled ? 1 : 0

  log_group_name = "${var.vpc_name}-log-group"
  kms_key_id     = var.kms_key_id
  tags           = var.tags
}

data "aws_iam_policy_document" "assume_role" {
  count = var.flow_log_enabled ? 1 : 0

  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

module "vpc_cloudwatch_iam_role" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/iam-role/1.0.0"

  count = var.flow_log_enabled ? 1 : 0

  iam_role_name               = "${var.vpc_name}-iam-role"
  assume_role_policy          = data.aws_iam_policy_document.assume_role[0].json
  iam_role_policy_attachments = var.iam_role_policy_attachments
  tags                        = var.tags
}

data "aws_iam_policy_document" "this" {
  count = var.flow_log_enabled ? 1 : 0

  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]

    resources = [
      "arn:aws:logs:${var.region}:${var.account_id}:log-group:${var.vpc_name}-log-group:*",
      "arn:aws:logs:${var.region}:${var.account_id}:log-group:${var.vpc_name}-log-group:log-stream:*"
    ]
  }
}

# This is an inline policy for the IAM role created above.
resource "aws_iam_role_policy" "this" {
  count = var.flow_log_enabled ? 1 : 0

  name   = "${var.vpc_name}-iam-role-policy"
  role   = module.vpc_cloudwatch_iam_role[count.index].name
  policy = data.aws_iam_policy_document.this[count.index].json
  // Tags are not supported for IAM role inline policies
}