module "aws_vpc_security_group_ingress_rule" {
  source            = "./aws_vpc_security_group_ingress_rule/1.0.0"
  security_group_id = module.aws_security_group.aws_security_group_id
  cidr_ipv4         = module.aws_vpc.cidr_block
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
  tags = {
    Name = "Outbound rule"
  }
}