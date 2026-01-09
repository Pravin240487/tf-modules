module "efs" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/qs-tf-modules.zip//storage/efs/1.0.0"

  name       = "example-efs"
  vpc_id     = "vpc-12345678"
  subnet_ids = ["subnet-12345678", "subnet-87654321"]
  tags = {
    Environment = "example"
    Project     = "efs-module"
  }
}

resource "aws_efs_mount_target" "example" {
  for_each        = toset(module.efs.subnet_ids)
  file_system_id  = module.efs.id
  subnet_id       = each.key
  security_groups = ["sg-12345678"]
}

output "efs_id" {
  value = module.efs.id
}

output "efs_dns_name" {
  value = module.efs.dns_name
}
