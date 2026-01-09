variable "create_iam_role" {
  description = "Whether to create an IAM role for the lambda function"
  type        = bool
  default     = true

}
variable "function_name" {
  description = "The name of the lambda function"
  type        = string

}
variable "package_type" {
  description = "The package type of the lambda function"
  type        = string
  default     = "Image"

}
variable "image_uri" {
  description = "The image URI of the lambda function"
  type        = string
  default     = ""

}
variable "memory_size" {
  description = "The memory size of the lambda function"
  type        = number
  default     = 128

}
variable "timeout" {
  description = "The timeout of the lambda function"
  type        = number
  default     = 3

}
variable "environment_variables" {
  description = "The environment variables of the lambda function"
  type        = map(string)
  default     = {}

}
variable "create_ecr_lambda" {
  description = "Whether to create an ECR lambda function"
  type        = bool
  default     = false

}
variable "archive_file_type" {
  description = "The type of the archive file"
  type        = string
  default     = "zip"

}
variable "source_dir" {
  description = "The source directory of the lambda function"
  type        = string
  default     = "./"

}
variable "output_path" {
  description = "The output path of the lambda function"
  type        = string
  default     = "./lambda.zip"

}
variable "lambda_handler" {
  description = "The handler of the lambda function"
  type        = string
  default     = "index.handler"
}
variable "lambda_runtime" {
  description = "The runtime of the lambda function"
  type        = string
  default     = "nodejs18.x"
}
variable "tags" {
  description = "The tags to apply to the lambda function"
  type        = map(string)
  default     = {}
}
variable "role_arn" {
  description = "The ARN of the IAM role for the lambda function"
  type        = string
  default     = ""

}
variable "subnet_ids" {
  description = "The subnet IDs for the lambda function"
  type        = list(string)
  default     = []
}
variable "security_group_ids" {
  description = "The security group IDs for the lambda function"
  type        = list(string)
  default     = []

}
variable "lambda_role_name" {
  description = "The name of the IAM role for the lambda function"
  type        = string
  default     = ""
}
variable "event_source_arn" {
  description = "The ARN of the event source for the lambda function"
  type        = string
  default     = ""
}
variable "batch_size" {
  default     = 10
  type        = number
  description = "batch size for the event source mapping"
}
variable "create_event_source_mapping" {
  default     = false
  type        = bool
  description = "Whether to create an event source mapping for the lambda function"

}
variable "publish" {
  type        = bool
  default     = false
}
