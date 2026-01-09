output "iam_role_name" {
  value       = module.iam_role[*].name
  description = "The name of the IAM role created for the Lambda function."

}
output "iam_role_arn" {
  value       = module.iam_role[*].arn
  description = "The ARN of the IAM role created for the Lambda function."

}
output "ecr_lambda_arn" {
  value       = aws_lambda_function.ecr_lambda[*].arn
  description = "The ARN of the ECR Lambda function."

}
output "lambda_arn" {
  value       = aws_lambda_function.lambda[*].arn
  description = "The ARN of the Lambda function."

}
output "qualified_arn" {
  value       = var.create_ecr_lambda ? "" : aws_lambda_function.lambda[0].qualified_arn
  description = "The qualified ARN of the Lambda function."
  
}