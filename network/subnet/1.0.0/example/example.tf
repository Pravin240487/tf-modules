module "subnet" {
  source = "./subnet/1.0.0"

  vpc_id            = module.vpc.id
  subnet_name       = "my-subnet-01"
  availability_zone = "eu-central-1a"
  cidr_block        = "10.1.0.0/24"
  tags = {
    Environment = "development"
  }
}