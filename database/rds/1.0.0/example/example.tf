# ==============================================================================
# AWS RDS Database Examples
# ==============================================================================

# Example 1: PostgreSQL with Enhanced Security
module "postgres_database" {
  source   = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//database/rds/1.0.0"

  # Basic database configuration
  db_instance_name      = "postgres-production-db"
  allocated_storage     = 100
  max_allocated_storage = 500
  db_name              = "application_db"
  
  # Engine configuration
  engine         = "postgres"
  engine_version = "15.4"
  instance_class = "db.r6g.large"

  # Authentication and security
  username               = "postgres_admin"
  password               = "securePassword123!" # Use a secure method to manage passwords
  storage_encrypted      = true
  enable_deletion_protection = true
  kms_key_id            = aws_kms_key.rds_encryption.arn

  # High availability and backup
  multi_az                = true
  skip_final_snapshot     = false
  copy_tags_to_snapshot   = true
  backup_retention_period = 7
  backup_window          = "03:00-04:00"

  # Maintenance and updates
  auto_minor_version_upgrade = false
  maintenance_window         = "sun:04:00-sun:05:00"
  apply_immediately         = false

  # Performance and monitoring
  performance_insights_enabled    = true
  performance_insights_kms_key_id = aws_kms_key.rds_encryption.arn
  monitoring_interval             = 60
  rds_monitoring_role_arn         = aws_iam_role.rds_monitoring.arn
  enabled_logs                    = ["postgresql"]

  # Storage configuration
  storage_type = "gp3"

  # Network configuration
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible    = false

  # Custom parameter group with security-focused settings
  parameter_group_name        = "postgres-secure-params"
  parameter_group_family      = "postgres15"
  parameter_group_description = "Secure parameter group for PostgreSQL database"
  
  parameters = [
    {
      name         = "rds.force_ssl"
      value        = "1"
      apply_method = "immediate"
    }
  ]

  tags = {
    Environment = "production"
    Database    = "postgresql"
    Security    = "enhanced"
    Purpose     = "application-database"
  }
}