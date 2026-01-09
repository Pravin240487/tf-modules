module "key_pair" {
  source      = "../"
  key_name    = "octonomy-key-pair"
  public_key_path = "./octonomy_rsa.pub"
}