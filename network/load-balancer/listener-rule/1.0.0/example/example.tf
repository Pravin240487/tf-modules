module "alb_listener_rule_https" {
  source = "./modules/listener-rule/1.0.0"

  aws_lb_listener_rule_name = "tbd-alb-listener-rule-https"
  listener_arn              = module.alb.https_listener_arn
  priority                  = 100
  target_group_arn          = module.target_group.arn
  stickiness_enabled        = true
  stickiness_duration       = 86400 # 1 day

  host_header = ["ai-agent.dev.octonomy.ai"]

  tags = {
    Environment = "development"
  }
}

module "alb_listener_rule_https_02" {
  source = "./modules/listener-rule/1.0.0"

  alb_listener_rule_name = "https-rule-02"
  listener_arn           = module.alb.https_listener_arn
  priority               = 200
  target_group_arn       = module.target_group.arn


  host_header  = ["*.dev.octonomy.ai"]
  path_pattern = ["/assets/*"]

  tags = {
    "Environment" = "dev"
  }
}

module "alb_listener_rule_https_03" {
  source = "./modules/listener-rule/1.0.0"

  alb_listener_rule_name = "https-rule-03"
  listener_arn           = module.alb.https_listener_arn
  priority               = 300
  target_group_arn       = module.target_group.arn


  host_header  = ["*.dev.assets.octonomy.ai", "*.dev.octonomy.ai"]
  path_pattern = ["/api/appconnect/*"]

  tags = {
    "Environment" = "dev"
  }
}
