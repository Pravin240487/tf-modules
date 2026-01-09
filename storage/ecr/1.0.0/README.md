# AWS ECR Repository Module

This module creates an AWS Elastic Container Registry (ECR) repository with simplified configuration optimized for cross-account access and pipeline-based scanning.

## Features

- Creates an ECR repository with mutable image tags
- AES256 encryption enabled by default
- Image scanning disabled (optimized for external scanning tools like Trivy)
- Cross-account access permissions for pulling images
- Comprehensive tagging support

## Usage

```hcl
module "ecr" {
  source = "path/to/ecr/module"
  
  repository_name = "my-application"
  force_delete    = false
  
  allowed_account_ids = [
    "123456789012",
    "987654321098",
    "555666777888"
  ]
  
  tags = {
    Environment = "production"
    Team        = "devops"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14 |
| aws | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| repository_name | The name of the ECR repository | `string` | n/a | yes |
| force_delete | If true, will delete the repository even if it contains images | `bool` | `false` | no |
| allowed_account_ids | List of AWS account IDs that are allowed to pull images from this ECR repository | `list(string)` | `[]` | no |
| tags | A map of tags to assign to the ECR repository | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| repository_arn | The ARN of the ECR repository |
| repository_name | The name of the ECR repository |
| repository_url | The URL of the ECR repository |
| registry_id | The registry ID where the repository was created |
| repository_uri | The URI of the ECR repository |