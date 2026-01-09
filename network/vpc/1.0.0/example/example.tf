module "vpc" {
  source = "./vpc/1.0.0"

  vpc_name         = "my-vpc"
  cidr_block       = "10.1.0.0/16"
  flow_log_enabled = true
  tags = {
    Environment = "development"
  }
}