locals {
  iam_policies = {
    "iam_001" = {
      name        = "GlueJobRunManagementFullAccessPolicy_v1"
      description = "GlueJobRunManagementFullAccessPolicy"
      statements = [{
        Action = [
          "glue:StartJobRun",
          "glue:GetJobRun",
          "glue:GetJobRuns",
          "glue:BatchStopJobRun"
        ],
        Effect   = "Allow"
        Resource = ["*"]
      }]
    }
  }
}

module "iam_policy" {
  source                = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/iampolicy/1.0.0"
  for_each              = local.iam_policies
  iam_policy_name       = each.value.name
  iam_policy_name_desc  = each.value.description
  iam_policy_statements = each.value.statements
  tags                  = var.tags
}