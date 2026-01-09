module "alb" {
  source             = "./modules/load-balancer/1.0.0"
  load_balancer_name = "tbd-alb"
  vpc_id             = module.vpc.id
  subnets            = [module.alb_subnet_01.id, module.alb_subnet_02.id, module.alb_subnet_03.id]
  certificate_arn    = "arn:aws:acm:eu-central-1:******:certificate/fdd7cd25-9324-4a3c-86e0-6b5b1f473f52"

  tags = {
    Environment = "development"
  }
}
