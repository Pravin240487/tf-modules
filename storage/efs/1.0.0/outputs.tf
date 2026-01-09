output "efs_sg_id" {
  description = "Security group id for EFS"
  value       = module.efs_sg.id

}
output "efs_sg_arn" {
  description = "Security group arn for EFS"
  value       = module.efs_sg.arn

}
output "efs_file_id" {
  description = "The ID of the created EFS file system"
  value       = aws_efs_file_system.efs.id
}
output "efs_file_dns_name" {
  description = "value of the EFS file system DNS name"
  value       = aws_efs_file_system.efs.dns_name
}