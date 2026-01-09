# ==============================================================================
# AWS Glue Data Connection Examples
# ==============================================================================

# Example 1: Basic JDBC Connection (PostgreSQL/MySQL)
module "glue_jdbc_connection" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//analytics/glue-data-connection/1.0.0"

  connection_name = "my-database-connection"

  connection_properties = {
    JDBC_CONNECTION_URL = "jdbc:postgresql://my-db.cluster-xyz.region.rds.amazonaws.com:5432/mydb"
    USERNAME            = "glue_user"
    PASSWORD            = "password123"
  }

  # VPC configuration for secure database access
  physical_connection_requirements = {
    availability_zone      = "us-east-1a"
    security_group_id_list = ["sg-12345678"]
    subnet_id              = "subnet-abcdef12"
  }

  tags = {
    Environment = "dev"
    Project     = "data-pipeline"
    Team        = "analytics"
  }
}