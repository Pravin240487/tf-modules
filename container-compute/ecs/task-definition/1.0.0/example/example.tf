variable "task_definitions" {
  description = "Map of ECS task definitions to create, keyed by task name"
  type = map(object({
    task_definition_name    = string
    container_name          = string
    ecr_repository_name     = string
    cpu                     = optional(number, 256)
    memory                  = optional(number, 512)
    container_port          = optional(number, 80)
    host_port               = optional(number, 80)
    skip_destroy            = optional(bool, true)
    secret_keys             = optional(list(string), [])
    kms_key_id              = optional(string, null)
    service_log_group_name  = optional(string, null)
    operating_system_family = optional(string, "LINUX")
    desired_count           = optional(number, 1)
  }))
  default = {}
}

module "task_definition" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//container-compute/ecs/task-definition/1.0.0"

  for_each = var.task_definitions

  task_definition_name    = "oc-${var.environment}-${var.region_suffix}-${each.value.task_definition_name}-task-${var.project_version}"
  container_name          = "oc-${var.environment}-${var.region_suffix}-${each.value.task_definition_name}-container-${var.project_version}"
  image                   = "${var.shared_account_id}.dkr.ecr.${var.region}.amazonaws.com/${each.value.ecr_repository_name}:${var.environment}"
  cpu                     = each.value.cpu
  memory                  = each.value.memory
  container_port          = each.value.container_port
  host_port               = each.value.host_port
  awslogs_region          = var.region
  task_iam_role_arn       = try(module.iam[each.key].arn, "")
  execution_iam_role_arn  = try(module.iam[each.key].arn, "")
  skip_destroy            = each.value.skip_destroy
  secret_arn              = try(module.secrets[each.key].secret_arn, "")
  secret_keys             = try(each.value.secret_keys, [])
  kms_key_id              = each.value.kms_key_id
  service_log_group_name  = "oc-${var.environment}-${var.region_suffix}-${each.value.service_log_group_name}-log-group-${var.project_version}"
  operating_system_family = each.value.operating_system_family
  tags                    = var.tags
}