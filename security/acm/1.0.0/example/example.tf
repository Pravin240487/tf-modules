module "acm" {
  source           = "../"
  domain_name      = "poc.dev.assets.octonomy.ai"
  hosted_zone_name = "dev.assets.octonomy.ai"
}