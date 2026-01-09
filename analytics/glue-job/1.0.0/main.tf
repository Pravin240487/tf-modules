resource "aws_glue_job" "this" {
  connections               = var.connections
  default_arguments         = var.default_arguments
  description               = var.description
  execution_class           = var.execution_class
  glue_version              = var.glue_version
  job_run_queuing_enabled   = var.job_run_queuing_enabled
  maintenance_window        = var.maintenance_window
  max_retries               = var.max_retries
  name                      = var.name
  non_overridable_arguments = var.non_overridable_arguments
  role_arn                  = var.role_arn
  security_configuration    = var.security_configuration
  timeout                   = var.timeout
  worker_type               = var.worker_type
  max_capacity              = var.max_capacity
  number_of_workers         = var.number_of_workers
  tags                      = var.tags

  command {
    name            = var.command_name
    python_version  = var.python_version
    script_location = var.script_location
  }

  execution_property {
    max_concurrent_runs = var.max_concurrent_runs
  }
}