resource "aws_efs_file_system" "efs" {
  creation_token = var.efs_token_name
  encrypted      = var.enable_encryption
  kms_key_id     = var.kms_key_id
  tags = {
    Name = var.efs_token_name
  }
}
module "efs_sg" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/network-security-group/security-group/1.0.0/"
  name   = var.efs_sg_name
  vpc_id = var.vpc_id
  tags   = var.tags
}
module "efs_egress" {
  source            = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/network-security-group/egress-rule/1.0.0/"
  security_group_id = module.efs_sg.id
  name              = "egress-${var.efs_sg_name}"
  description       = "egress rule for the efs"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  tags              = var.tags
}
module "efs_ingress" {
  source            = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/network-security-group/ingress-rule/1.0.0/"
  security_group_id = module.efs_sg.id
  name              = "ingress-${var.efs_sg_name}"
  description       = "ingress rule for the efs"
  cidr_ipv4         = var.cidr_block
  from_port         = 2049
  ip_protocol       = "tcp"
  to_port           = 2049
  tags              = var.tags
}
resource "aws_efs_mount_target" "efs_mount" {
  count = length(var.private_subnet_ids)

  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = var.private_subnet_ids[count.index]
  security_groups = [module.efs_sg.id]
}