# Changelog

All notable changes to the AWS EventBridge Scheduler Terraform module will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-09-30

### Added
- Initial release of AWS EventBridge Scheduler Terraform module
- Support for creating EventBridge schedules with flexible configuration
- Support for multiple target types (Lambda, Step Functions, SQS, etc.)
- Configurable schedule expressions (rate-based, cron-based, one-time)
- Timezone support for schedule expressions
- Flexible time window configuration with ON/OFF modes
- Retry policy configuration with customizable parameters
- Target input customization with job metadata (jobId, jobType, tenantId)
- Tags support for resource organization and cost tracking
- Comprehensive variable validation and documentation
- Example configurations for common use cases:
  - Daily Lambda function execution
  - ETL pipeline triggers every 30 minutes
  - Weekday report generation
  - One-time migration tasks
  - High-frequency monitoring during business hours

### Features
- **Schedule Types**: 
  - Rate-based schedules (e.g., `rate(1 day)`, `rate(30 minutes)`)
  - Cron-based schedules (e.g., `cron(0 8 ? * MON-FRI *)`)
  - One-time schedules (e.g., `at(2024-12-31T23:59:59)`)
- **Target Support**: Lambda functions, Step Functions, SQS queues, and other EventBridge targets
- **Timezone Awareness**: Support for various timezones (UTC, America/New_York, etc.)
- **Flexible Execution**: Configurable time windows for schedule flexibility
- **Error Handling**: Customizable retry policies with event age and attempt limits
- **Monitoring**: Built-in state management (ENABLED/DISABLED)
- **Metadata**: Custom input parameters for job tracking and tenant isolation

### Configuration Options
- `description`: Human-readable description of the scheduler
- `group_name`: Organization grouping for related schedules
- `name`: Unique identifier for the schedule
- `schedule_expression`: When to execute (rate, cron, or at expressions)
- `schedule_expression_timezone`: Timezone for schedule execution
- `state`: Enable or disable the schedule
- `flexible_time_window`: Execution flexibility configuration
- `target`: Target service configuration (ARN and IAM role)
- `retry_policy`: Error handling and retry configuration
- `job_id`, `job_type`, `tenant_id`: Custom metadata for target input
- `tags`: Resource tagging for organization and cost management

### Examples Included
- **Daily Processing**: Lambda function execution every day
- **ETL Pipeline**: Step Function triggers every 30 minutes
- **Business Reports**: SQS queue messages on weekdays
- **Data Migration**: One-time scheduled tasks
- **Health Monitoring**: High-frequency checks during business hours

### Files Structure
```
scheduler/1.0.0/
├── main.tf              # Core resource definitions
├── variables.tf         # Input variable declarations
├── outputs.tf          # Output value definitions
├── example/
│   └── example.tf      # Usage examples and best practices
└── changelog.md        # This changelog file
```

### Dependencies
- AWS Provider >= 5.0
- Terraform >= 1.0

### Security Considerations
- Requires appropriate IAM roles for EventBridge Scheduler execution
- Target resources must have proper permissions for the scheduler role
- Consider least privilege principles when configuring IAM roles
- Sensitive data should not be passed in plain text through input parameters

### Best Practices
- Use descriptive names and groups for better organization
- Set appropriate retry policies based on target service characteristics
- Use timezone-aware scheduling for user-facing applications
- Implement proper error handling and monitoring
- Tag resources consistently for cost tracking and organization
- Test schedules in non-production environments first

---

**Note**: This module follows AWS EventBridge Scheduler best practices and supports all major scheduling patterns. For detailed usage examples, refer to the `example/` directory.
