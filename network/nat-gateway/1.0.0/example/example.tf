module "nat-gateway" {
  source = "./modules/nat-gateway/1.0.0"

  subnet_id        = module.nat_subnet.id
  nat_gateway_name = "my-nat-gateway"
  tags = {
    Environment = "development"
  }
  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [module.internet-gateway]
}