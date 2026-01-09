module "target_group" {
  source            = "./modules/target-group/v1.0.0"
  target_group_name = "tbd-target-group"

  vpc_id = module.vpc.id

  enable_stickiness = true

  tags = {
    Environment = "development"
  }
}
