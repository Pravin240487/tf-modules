# Example Terraform configuration for using a module

module "lambda_function" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//container-compute/lambda/1.0.0" # Adjust the path to the module as needed

  function_name = "example-lambda-function"
  runtime       = "nodejs16.x"
  handler       = "index.handler"
  role_arn      = "arn:aws:iam::123456789012:role/example-role"

  environment_variables = {
    ENV_VAR_1 = "value1"
    ENV_VAR_2 = "value2"
  }

  tags = {
    Name        = "example-lambda-function"
    Environment = "development"
  }
}
