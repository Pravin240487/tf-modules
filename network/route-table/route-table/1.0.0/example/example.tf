module "public_route_table" {
  source = "./modules/route-table/1.0.0"

  vpc_id           = module.vpc.id
  route_table_name = "public-route-table"
  tags = {
    Environment = "development"
  }
}