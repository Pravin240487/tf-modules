# ==============================================================================
# AWS RDS Subnet Group Examples
# ==============================================================================

# Example 1: Basic RDS Subnet Group for Production
module "production_rds_subnet_group" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//database/rds-subnet-group/1.0.0"

  db_subnet_group_name = "prod-rds-subnet-group"
  description          = "Production RDS subnet group spanning multiple AZs"

  subnet_ids = [
    "subnet-0123456789abcdef0", # Private subnet in us-east-1a
    "subnet-0987654321fedcba0", # Private subnet in us-east-1b
    "subnet-0456789012345678f"  # Private subnet in us-east-1c
  ]

  tags = {
    Environment = "production"
    Purpose     = "rds-database"
    Team        = "database-admin"
    Backup      = "critical"
  }
}