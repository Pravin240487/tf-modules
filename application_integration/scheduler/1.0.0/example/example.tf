provider "aws" {
  region = "us-east-1"
}

# Example 1: Lambda Function Scheduler - Daily at 9 AM UTC
module "daily_lambda_scheduler" {
  source = "../" # Path to the scheduler module

  name                         = "daily-data-processing"
  description                  = "Daily data processing job scheduler"
  group_name                   = "data-processing-group"
  schedule_expression          = "rate(1 day)"
  schedule_expression_timezone = "UTC"
  state                        = "ENABLED"

  flexible_time_window = {
    mode                      = "FLEXIBLE"
    maximum_window_in_minutes = 15
  }

  target = {
    arn      = "arn:aws:lambda:us-east-1:123456789012:function:data-processor"
    role_arn = "arn:aws:iam::123456789012:role/EventBridgeSchedulerRole"
  }

  retry_policy = {
    maximum_event_age_in_seconds = 3600  # 1 hour
    maximum_retry_attempts       = 3
  }

  job_id    = "daily-job-001"
  job_type  = "data-processing"
  tenant_id = "tenant-abc123"

  tags = {
    Environment = "production"
    Team        = "data-engineering"
    Purpose     = "daily-processing"
  }
}

# Example 2: Step Function Scheduler - Every 30 minutes
module "stepfunction_scheduler" {
  source = "../" # Path to the scheduler module

  name                         = "etl-pipeline-trigger"
  description                  = "ETL pipeline trigger every 30 minutes"
  group_name                   = "etl-group"
  schedule_expression          = "rate(30 minutes)"
  schedule_expression_timezone = "America/New_York"
  state                        = "ENABLED"

  flexible_time_window = {
    mode                      = "OFF"
    maximum_window_in_minutes = 0
  }

  target = {
    arn      = "arn:aws:states:us-east-1:123456789012:stateMachine:etl-pipeline"
    role_arn = "arn:aws:iam::123456789012:role/EventBridgeSchedulerRole"
  }

  retry_policy = {
    maximum_event_age_in_seconds = 7200  # 2 hours
    maximum_retry_attempts       = 5
  }

  job_id    = "etl-job-002"
  job_type  = "etl-processing"
  tenant_id = "tenant-xyz789"

  tags = {
    Environment = "production"
    Team        = "data-engineering"
    Purpose     = "etl-pipeline"
  }
}

# Example 3: SQS Queue Scheduler - Weekdays at 8 AM
module "sqs_scheduler" {
  source = "../" # Path to the scheduler module

  name                         = "weekday-report-generator"
  description                  = "Generate reports every weekday at 8 AM"
  group_name                   = "reporting-group"
  schedule_expression          = "cron(0 8 ? * MON-FRI *)"
  schedule_expression_timezone = "America/Los_Angeles"
  state                        = "ENABLED"

  flexible_time_window = {
    mode                      = "FLEXIBLE"
    maximum_window_in_minutes = 30
  }

  target = {
    arn      = "arn:aws:sqs:us-east-1:123456789012:report-queue"
    role_arn = "arn:aws:iam::123456789012:role/EventBridgeSchedulerRole"
  }

  retry_policy = {
    maximum_event_age_in_seconds = 86400  # 24 hours
    maximum_retry_attempts       = 2
  }

  job_id    = "report-job-003"
  job_type  = "report-generation"
  tenant_id = "tenant-rep456"

  tags = {
    Environment = "production"
    Team        = "business-intelligence"
    Purpose     = "reporting"
    Schedule    = "weekdays"
  }
}

# Example 4: One-time Scheduler - Specific date and time
module "onetime_scheduler" {
  source = "../" # Path to the scheduler module

  name                         = "migration-task"
  description                  = "One-time data migration task"
  group_name                   = "migration-group"
  schedule_expression          = "at(2024-12-31T23:59:59)"
  schedule_expression_timezone = "UTC"
  state                        = "ENABLED"

  flexible_time_window = {
    mode                      = "OFF"
    maximum_window_in_minutes = 0
  }

  target = {
    arn      = "arn:aws:lambda:us-east-1:123456789012:function:data-migration"
    role_arn = "arn:aws:iam::123456789012:role/EventBridgeSchedulerRole"
  }

  retry_policy = {
    maximum_event_age_in_seconds = 1800   # 30 minutes
    maximum_retry_attempts       = 1
  }

  job_id    = "migration-job-004"
  job_type  = "data-migration"
  tenant_id = "tenant-mig789"

  tags = {
    Environment = "production"
    Team        = "platform"
    Purpose     = "migration"
    Type        = "one-time"
  }
}

# Example 5: High-frequency Scheduler - Every 5 minutes during business hours
module "high_frequency_scheduler" {
  source = "../" # Path to the scheduler module

  name                         = "health-check-monitor"
  description                  = "Health check monitoring every 5 minutes during business hours"
  group_name                   = "monitoring-group"
  schedule_expression          = "cron(*/5 9-17 ? * MON-FRI *)"
  schedule_expression_timezone = "America/New_York"
  state                        = "ENABLED"

  flexible_time_window = {
    mode                      = "FLEXIBLE"
    maximum_window_in_minutes = 2
  }

  target = {
    arn      = "arn:aws:lambda:us-east-1:123456789012:function:health-check"
    role_arn = "arn:aws:iam::123456789012:role/EventBridgeSchedulerRole"
  }

  retry_policy = {
    maximum_event_age_in_seconds = 300    # 5 minutes
    maximum_retry_attempts       = 2
  }

  job_id    = "health-check-005"
  job_type  = "monitoring"
  tenant_id = "tenant-mon123"

  tags = {
    Environment = "production"
    Team        = "devops"
    Purpose     = "monitoring"
    Frequency   = "high"
  }
}

# Output examples
output "daily_scheduler_arn" {
  description = "ARN of the daily lambda scheduler"
  value       = module.daily_lambda_scheduler.schedule_arn
}

output "etl_scheduler_name" {
  description = "Name of the ETL scheduler"
  value       = module.stepfunction_scheduler.schedule_name
}

output "report_scheduler_state" {
  description = "State of the report scheduler"
  value       = module.sqs_scheduler.schedule_state
}
