variable "task_definition_name" {
  description = "The name of the ECS task definition."
  type        = string
}

variable "container_name" {
  description = "The name of the container within the ECS task definition."
  type        = string
}

variable "image" {
  description = "The Docker image to use for the container."
  type        = string
}

variable "cpu" {
  description = "The number of CPU units to allocate to the container."
  type        = number
  default     = 256
}

variable "memory" {
  description = "The amount of memory (in MiB) to allocate to the container."
  type        = number
  default     = 512
}

variable "container_port" {
  description = "The port on which the container listens."
  type        = number
  default     = 80
}

variable "host_port" {
  description = "The port on the host to map to the container port."
  type        = number
  default     = 80
}

variable "awslogs_region" {
  description = "The AWS region for CloudWatch logs."
  type        = string
}

variable "task_iam_role_arn" {
  description = "The ARN of the task IAM role to use for the ECS task."
  type        = string
}

variable "execution_iam_role_arn" {
  description = "The ARN of the execution IAM role to use for the ECS task."
  type        = string
}

variable "skip_destroy" {
  description = "Whether to skip the destroy operation for the ECS task definition."
  type        = bool
  default     = true
}

variable "secret_arn" {
  description = "The ARN of the AWS Secrets Manager secret containing sensitive data."
  type        = string
  default     = ""
}

variable "secret_keys" {
  description = "A list of secret keys to retrieve from the Secrets Manager."
  type        = list(string)
  default     = []
}

variable "kms_key_id" {
  description = "The KMS key ID for encrypting CloudWatch logs."
  type        = string
}

variable "service_log_group_name" {
  description = "The name of the log group for the ECS service."
  type        = string
}

variable "operating_system_family" {
  description = "The operating system family for the ECS task definition."
  type        = string
  default     = "LINUX"
}

variable "entry_point" {
  description = "The entry point for the container."
  type        = list(string)
  default     = []
}

variable "command" {
  description = "The command to run in the container."
  type        = list(string)
  default     = []
}

variable "environment" {
  description = "The environment variables to set in the container."
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "tags" {
  description = "A map of tags to assign to the ECS task definition."
  type        = map(string)
}