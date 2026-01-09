resource "aws_eip" "this" {
  domain = "vpc"
  tags = merge(
    {
      Name = var.elastic_ip_name
    },
    var.tags
  )
}