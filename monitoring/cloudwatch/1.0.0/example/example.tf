module "vpc_cloudwatch_log_group" {
  source = "../../../monitoring/cloudwatch/1.0.0"

  count = var.flow_log_enabled ? 1 : 0

  log_group_name = "${var.vpc_name}-log-group"
  kms_key_id     = var.kms_key_id
  tags           = var.tags
}