module "ecr_repository" {
  source = "../"

  repository_name = "my-application"
  force_delete    = false

  allowed_account_ids = [
    "123456789012",
    "987654321098",
    "555666777888"
  ]

  tags = {
    Environment = "example"
    Team        = "DevOps"
    Project     = "efs-module"
  }
}