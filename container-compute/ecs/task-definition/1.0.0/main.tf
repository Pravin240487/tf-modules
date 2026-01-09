locals {
  secret_arn  = var.secret_arn
  secret_keys = distinct(var.secret_keys)
}

# Generate secrets block
locals {
  container_secrets = var.secret_arn != "" && length(var.secret_keys) > 0 ? [
    for key in local.secret_keys : {
      name      = key
      valueFrom = "${local.secret_arn}:${key}::"
    }
  ] : []
}

module "ecs_cloudwatch_log_group" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//monitoring/cloudwatch/1.0.0"

  log_group_name = var.service_log_group_name
  kms_key_id     = var.kms_key_id
  tags           = var.tags
}

resource "aws_ecs_task_definition" "this" {
  family                   = var.task_definition_name
  requires_compatibilities = ["FARGATE"]
  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.image
      cpu       = var.cpu
      memory    = var.memory
      essential = true
      entryPoint = var.entry_point
      command    = var.command
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.host_port
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = var.service_log_group_name
          awslogs-region        = var.awslogs_region
          awslogs-stream-prefix = "ecs"
        }
      }
      environment = length(var.environment) > 0 ? var.environment : null
      secrets = length(local.container_secrets) > 0 ? local.container_secrets : null
    }
  ])
  network_mode       = "awsvpc"
  cpu                = var.cpu
  memory             = var.memory
  task_role_arn      = var.task_iam_role_arn
  execution_role_arn = var.execution_iam_role_arn
  runtime_platform {
    operating_system_family = var.operating_system_family
    cpu_architecture        = "X86_64"
  }
  skip_destroy = var.skip_destroy
  tags         = var.tags

  depends_on = [module.ecs_cloudwatch_log_group]
}
