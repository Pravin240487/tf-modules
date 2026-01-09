resource "aws_scheduler_schedule" "this" {

  description                  = var.description
  group_name                   = var.group_name
  name                         = var.name
  schedule_expression          = var.schedule_expression
  schedule_expression_timezone = var.schedule_expression_timezone
  state                        = var.state

  flexible_time_window {
    maximum_window_in_minutes = var.flexible_time_window.maximum_window_in_minutes
    mode                      = var.flexible_time_window.mode
  }

  target {
    arn     = var.target.arn
    input   = jsonencode({
      jobId    = var.job_id
      jobType  = var.job_type
      tenantId = var.tenant_id
    })
    role_arn = var.target.role_arn
    retry_policy {
      maximum_event_age_in_seconds = var.retry_policy.maximum_event_age_in_seconds
      maximum_retry_attempts       = var.retry_policy.maximum_retry_attempts
    }
  }
}