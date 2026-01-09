output "ebs_volume_id" {
  value = aws_ebs_volume.data_volume.id
  description = "ID of the EBS volume created"
}
output "arn" {
  value = aws_ebs_volume.data_volume.arn
  description = "ARN of the EBS volume created"
  
}