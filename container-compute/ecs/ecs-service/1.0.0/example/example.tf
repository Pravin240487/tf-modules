module "ecs_service" {
  source = "../../"

  name                = "example-ecs-service"
  cluster_arn         = "arn:aws:ecs:region:account_id:cluster/example-cluster"
  task_definition_arn = "arn:aws:ecs:region:account_id:task/example-task"
  desired_count       = 2

  network_configuration = {
    subnets          = ["subnet-12345678", "subnet-87654321"]
    security_groups  = ["sg-12345678"]
    assign_public_ip = false
  }

  tags = {
    Environment = "example"
    Project     = "ecs-service"
  }
}