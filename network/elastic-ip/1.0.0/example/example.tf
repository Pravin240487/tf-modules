module "elastic_ip" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/elastic-ip/1.0.0"

  elastic_ip_name = "${var.nat_gateway_name}-eip"
  tags            = var.tags
}