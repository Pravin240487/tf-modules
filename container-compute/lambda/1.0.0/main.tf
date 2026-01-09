
module "iam_role" {
  source        = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/iam-role/1.0.0"
  iam_role_name = var.lambda_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
  tags  = var.tags
  count = var.create_iam_role ? 1 : 0
}

resource "aws_lambda_function" "ecr_lambda" {
  function_name = var.function_name
  package_type  = var.package_type
  role          = var.create_iam_role ? module.iam_role[count.index].arn : var.role_arn
  image_uri     = var.image_uri
  memory_size   = var.memory_size
  timeout       = var.timeout
  environment {
    variables = var.environment_variables
  }
  dynamic "vpc_config" {
    for_each = length(var.subnet_ids) > 0 && length(var.security_group_ids) > 0 ? [1] : []
    content {
      subnet_ids         = var.subnet_ids
      security_group_ids = var.security_group_ids
    }
  }
  tags  = var.tags
  count = var.create_ecr_lambda ? 1 : 0
}

data "archive_file" "lambda_source" {
  type        = var.archive_file_type
  source_dir  = var.source_dir
  output_path = var.output_path
  count       = var.create_ecr_lambda ? 0 : 1
}

resource "aws_lambda_function" "lambda" {
  filename         = data.archive_file.lambda_source[count.index].output_path
  function_name    = var.function_name
  role             = var.create_iam_role ? module.iam_role[count.index].arn : var.role_arn
  handler          = var.lambda_handler
  runtime          = var.lambda_runtime
  timeout          = var.timeout
  memory_size      = var.memory_size
  source_code_hash = data.archive_file.lambda_source[count.index].output_base64sha256
  environment {
    variables = var.environment_variables
  }
  dynamic "vpc_config" {
    for_each = length(var.subnet_ids) > 0 && length(var.security_group_ids) > 0 ? [1] : []
    content {
      subnet_ids         = var.subnet_ids
      security_group_ids = var.security_group_ids
    }
  }
  tags  = var.tags
  publish = var.publish
  count = var.create_ecr_lambda ? 0 : 1
}
resource "aws_lambda_event_source_mapping" "trigger" {
  event_source_arn = var.event_source_arn
  function_name    = var.create_ecr_lambda ? aws_lambda_function.ecr_lambda[count.index].arn : aws_lambda_function.lambda[count.index].arn
  batch_size       = var.batch_size
  count            = var.create_event_source_mapping ? 1 : 0

  depends_on = [ aws_lambda_function.ecr_lambda]
}
