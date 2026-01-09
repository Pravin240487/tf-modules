module "ebs" {
  source = "../"

  availability_zone = "us-east-1a"
  volume_size       = 10
  volume_type       = "gp2"

  tags = {
    Name = "example-ebs-volume"
  }
}