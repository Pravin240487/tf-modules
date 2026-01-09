module "ecs_cluster" {
  source       = "./ecs-cluster/1.0.0"
  cluster_name = "example-cluster"

  tags = {
    Environment = "example"
  }
}