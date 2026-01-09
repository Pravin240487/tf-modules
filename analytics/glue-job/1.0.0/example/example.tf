module "glue_job" {
  source = "../"

  name                    = "example-glue-job"
  role_arn                = "arn:aws:iam::123456789012:role/glue-job-role"
  glue_version            = "4.0"
  worker_type             = "G.1X"
  max_concurrent_runs     = 1
  max_retries             = 2
  timeout                 = 10
  description             = "Example Glue Job"
  execution_class         = "STANDARD"
  job_run_queuing_enabled = false
  maintenance_window      = "SUNDAY"
  security_configuration  = null
  max_capacity            = 1.0
  tags = {
    Environment = "dev"
    Project     = "analytics"
  }
  connections = ["example-glue-connection"]
  default_arguments = {
    "--TempDir"      = "s3://example-bucket/temp/"
    "--job-language" = "python"
  }
  non_overridable_arguments = {}
  command_name              = "glueetl"
  python_version            = "3"
  script_location           = "s3://example-bucket/scripts/example-script.py"
}