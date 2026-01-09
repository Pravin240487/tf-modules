output "instance_id" {
  value = aws_instance.this.id
}

output "public_ip" {
  value = aws_instance.this.public_ip
}

output "private_ip" {
  value = aws_instance.this.private_ip
}
output "ebs_volume_id" {
  value = module.ebs_volume[*].ebs_volume_id
  description = "ID of the EBS volume created"
  
}