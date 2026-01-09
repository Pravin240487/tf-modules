module "public_subnet_route_table_association" {
  source = "./modules/route-table-association/1.0.0"

  subnet_id      = module.public_subnet.id
  route_table_id = module.public_route_table.id
}