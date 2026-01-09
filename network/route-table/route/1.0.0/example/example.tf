module "public_route" {
  source = "./modules/route/1.0.0"

  route_table_id         = module.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = module.internet-gateway.id

}