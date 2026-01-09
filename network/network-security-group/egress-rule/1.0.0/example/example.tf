module "aws_vpc_security_group_egress_rule" {
  source            = "./aws_vpc_security_group_egress_rule/1.0.0"
  security_group_id = module.aws_security_group.aws_security_group_id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  tags = {
    Name = "Outbound rule"
  }
}