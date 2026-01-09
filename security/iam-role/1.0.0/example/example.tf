module "aws_iam_role" {
  source             = "./aws_iam_role/1.0.0"
  name               = "qs-dev-ec1-api-ecs-iam-role"
  assume_role_policy = data.aws_iam_policy_document.this.json
  tags = {
    Temp = "Temp"
  }
}