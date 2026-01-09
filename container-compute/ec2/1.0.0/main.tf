module "key_pair" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/key-pair/1.0.0"
  name = var.name
  ssh_pub_key = var.ssh_pub_key
  tags = var.tags
  count = var.key_pair_name == "" ? 1 : 0
}
resource "aws_instance" "this" {
  ami                     = var.ami
  instance_type           = var.instance_type
  disable_api_stop        = var.stop_protection
  disable_api_termination = var.delete_protection
  key_name                = var.key_pair_name == "" ? module.key_pair[0].name : var.key_pair_name
  iam_instance_profile    = var.iam_instance_profile
  user_data               = var.user_data
  subnet_id               = var.subnet_id
  vpc_security_group_ids  = var.security_group_ids
  associate_public_ip_address = var.associate_public_ip
  root_block_device {
    encrypted = var.root_block_device_encrypted
    volume_size = var.root_volume_size        
    volume_type = var.root_volume_type        
    delete_on_termination = var.deletion_on_termination           
  }
    metadata_options {
    http_tokens = var.http_tokens    
    http_put_response_hop_limit = var.http_put_response_hop_limit
    http_endpoint = var.http_endpoint
  }

  tags = merge(
    var.tags,
    {
      "Name" = var.name
    }
  )

}

module "ebs_volume" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//storage/ebs/1.0.0"
  availability_zone = var.availability_zone
  ebs_volume_size   = var.ebs_volume_size
  ebs_type          = var.ebs_type
  encrypted         = var.encrypted
  kms_key_id        = var.kms_key_id
  name              = var.name
  tags              = var.tags
  count             = var.enable_ebs_volume ? 1 : 0
}

resource "aws_volume_attachment" "data_volume_attachment" {
  count          = var.enable_ebs_volume ? 1 : 0
  device_name    = var.volume_device_name
  volume_id      = module.ebs_volume[count.index].ebs_volume_id
  instance_id    = aws_instance.this.id
}