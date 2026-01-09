resource "aws_ebs_volume" "data_volume" {
  availability_zone = var.availability_zone
  size              = var.ebs_volume_size
  type              = var.ebs_type
  encrypted = var.encrypted
  kms_key_id = var.kms_key_id

    tags = merge(
    var.tags,
    {
       Name = "${var.name}"
    }
  )
}
