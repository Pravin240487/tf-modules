module "internet-gateway" {
  source = "./modules/internet-gateway/1.0.0"

  vpc_id                = module.vpc.id
  internet_gateway_name = "my-internet-gateway"
  tags = {
    Environment = "development"
  }
}