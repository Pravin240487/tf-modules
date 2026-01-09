module "aws_security_group" {
  source      = "./aws_security_group/1.0.0"
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = module.aws_vpc.vpc_id
  tags = {
    Name = "allow_tls"
  }
}