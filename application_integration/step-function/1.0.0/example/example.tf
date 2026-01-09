# ==============================================================================
# AWS Step Functions Examples
# ==============================================================================

module "etl_pipeline_step_function" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//application_integration/step-function/1.0.0"

  name     = "etl-data-processing-pipeline"
  role_arn = "arn:aws:iam::123456789012:role/StepFunctionExecutionRole"
  
  definition = jsonencode({
    Comment = "ETL Pipeline for data processing"
    StartAt = "ExtractData"
    States = {
      ExtractData = {
        Type     = "Task"
        Resource = "arn:aws:states:::glue:startJobRun.sync"
        Parameters = {
          JobName = "extract-raw-data"
        }
        Next = "TransformData"
      }
      TransformData = {
        Type     = "Task"
        Resource = "arn:aws:states:::glue:startJobRun.sync"
        Parameters = {
          JobName = "transform-clean-data"
        }
        Next = "LoadData"
      }
      LoadData = {
        Type     = "Task"
        Resource = "arn:aws:states:::glue:startJobRun.sync"
        Parameters = {
          JobName = "load-to-warehouse"
        }
        End = true
      }
    }
  })

  # Enable comprehensive logging
  enable_logging         = true
  log_level             = "ALL"
  include_execution_data = true
  log_destination       = "arn:aws:logs:us-east-1:123456789012:log-group:/aws/stepfunctions/etl-pipeline"

  # Enable tracing for performance monitoring
  enable_tracing = true

  tags = {
    Environment = "production"
    Project     = "data-analytics"
    Pipeline    = "etl"
    Team        = "data-engineering"
  }
}