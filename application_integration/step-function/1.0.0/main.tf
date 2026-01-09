# AWS Step Functions State Machine for workflow orchestration
resource "aws_sfn_state_machine" "this" {
  name     = var.name
  role_arn = var.role_arn

  # Amazon States Language (ASL) definition for workflow logic
  definition = var.definition

  # Configure CloudWatch logging when enabled
  dynamic "logging_configuration" {
    for_each = var.enable_logging ? [1] : []
    content {
      level                  = var.log_level
      include_execution_data = var.include_execution_data
      log_destination        = var.log_destination
    }
  }

  # Configure AWS X-Ray tracing when enabled
  dynamic "tracing_configuration" {
    for_each = var.enable_tracing ? [1] : []
    content {
      enabled = var.enable_tracing
    }
  }

  tags = var.tags
}