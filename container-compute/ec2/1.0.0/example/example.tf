provider "aws" {
  region = "eu-central-1"
}

module "ec2_instance" {
  source              = "./path/to/module"

  ami                   = "ami-0fc5d935ebf8bc3bc"        # Replace with your AMI ID
  instance_type         = "t3.medium"
  subnet_id             = "subnet-0123456789abcdef0"    # Replace with your subnet ID
  vpc_security_group_ids = ["sg-0123456789abcdef0"]     # Replace with your SG ID(s)
  key_pair              = "my-keypair"                  # Replace with your key pair name
  iam_instance_profile  = "my-iam-instance-profile"     # Replace if you use one
  user_data             = file("${path.module}/user_data.sh")
  name                  = "example-ec2-instance"
  tags = {
    Environment = "dev"
    Project     = "terraform-module-test"
  }

  enable_ebs_volume     = true
  ebs_volume_size       = 100
}

output "instance_id" {
  value = module.ec2_instance.instance_id
}

output "public_ip" {
  value = module.ec2_instance.public_ip
}

output "data_volume_id" {
  value = module.ec2_instance.data_volume_id
}
