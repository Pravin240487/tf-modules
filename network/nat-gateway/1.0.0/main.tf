module "elastic_ip" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/elastic-ip/1.0.0"

  elastic_ip_name = "${var.nat_gateway_name}-eip"
  tags            = var.tags
}

resource "aws_nat_gateway" "this" {
  allocation_id = module.elastic_ip.id
  subnet_id     = var.subnet_id

  tags = merge(
    {
      Name = var.nat_gateway_name
    },
    var.tags
  )
}