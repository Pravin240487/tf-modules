module "vpc-endpoint" {
  source = "./modules/vpc-endpoint/v1.0.0"

  vpc_id          = "your-vpc-id"
  service_name    = "com.amazonaws.us-east-1.s3" # Example service name for S3
  route_table_ids = ["your-route-table-id"]

  tags = {
    Environment = "development"
  }
}