# AWS SQS Queue Terraform Module

This Terraform module provisions Amazon SQS queues with support for both standard and FIFO (First-In-First-Out) queues, including:
- Dead Letter Queue (DLQ) support for both standard and FIFO queues
- Server-side encryption using AWS-managed or customer-managed KMS keys
- FIFO queue configurations including high-throughput FIFO
- Content-based deduplication and custom deduplication scopes
- Redrive policy setup

## Features

- Creates standard or FIFO SQS queues with advanced configuration options
- Optionally creates a Dead Letter Queue (DLQ) with same queue type as primary
- Adds redrive policy linking main queue to DLQ
- Supports FIFO-specific features: ordering, deduplication, and high-throughput mode
- Supports managed or customer-managed encryption
- Fully taggable
- Automatic `.fifo` suffix handling for FIFO queues

## Usage

### Standard SQS Queue

```hcl
module "standard_sqs_queue" {
  source = "./path-to-this-module"

  sqs_name                    = "my-app-queue"
  delay_seconds               = 30
  max_message_size            = 262144
  message_retention_seconds   = 86400
  receive_wait_time_seconds   = 10
  visibility_timeout_seconds  = 45
  sqs_managed_sse_enabled     = true
  kms_master_key_id           = "alias/aws/sqs"

  create_dlq                     = true
  dlq_name                      = "my-app-dlq"
  dlq_message_retention_seconds = 345600
  max_receive_count             = 5

  tags = {
    Environment = "production"
    Team        = "backend"
  }
}
```

### FIFO SQS Queue

```hcl
module "fifo_sqs_queue" {
  source = "./path-to-this-module"

  sqs_name                   = "my-fifo-queue"  # Will become "my-fifo-queue.fifo"
  fifo_queue                 = true
  content_based_deduplication = true
  deduplication_scope        = "queue"
  fifo_throughput_limit      = "perQueue"
  
  delay_seconds              = 0  # Must be 0 for FIFO queues
  max_message_size           = 262144
  message_retention_seconds  = 86400
  receive_wait_time_seconds  = 10
  visibility_timeout_seconds = 45
  sqs_managed_sse_enabled    = true
  kms_master_key_id         = "alias/aws/sqs"

  create_dlq                     = true
  dlq_name                      = "my-fifo-queue-dlq"  # Will become "my-fifo-queue-dlq.fifo"
  dlq_message_retention_seconds = 345600
  max_receive_count             = 3

  tags = {
    Environment = "production"
    Team        = "backend"
    QueueType   = "FIFO"
  }
}
```

### High-Throughput FIFO Queue

```hcl
module "high_throughput_fifo" {
  source = "./path-to-this-module"

  sqs_name                   = "my-high-throughput-fifo"
  fifo_queue                 = true
  content_based_deduplication = false  # Requires MessageDeduplicationId in messages
  deduplication_scope        = "messageGroup"
  fifo_throughput_limit      = "perMessageGroupId"
  
  delay_seconds              = 0
  visibility_timeout_seconds = 30
  sqs_managed_sse_enabled    = true
  kms_master_key_id         = "alias/aws/sqs"

  tags = {
    Environment = "production"
    QueueType   = "FIFO"
    Throughput  = "High"
  }
}
```

## Variables

### General Configuration

| Variable | Type | Default | Required | Description |
|----------|------|---------|----------|-------------|
| `sqs_name` | `string` | - | Yes | Name of the SQS Queue |
| `delay_seconds` | `number` | `90` | No | The time in seconds that the delivery of all messages in the queue will be delayed. Must be 0 for FIFO queues |
| `max_message_size` | `number` | `262144` | No | The limit of how many bytes a message can contain before Amazon SQS rejects it |
| `message_retention_seconds` | `number` | `86400` | No | The number of seconds Amazon SQS retains a message |
| `receive_wait_time_seconds` | `number` | `5` | No | The time for which a ReceiveMessage call will wait for a message to arrive |
| `visibility_timeout_seconds` | `number` | `30` | No | The visibility timeout for the queue |
| `tags` | `map(string)` | - | Yes | Tags for the SQS Queue |

### FIFO Configuration

| Variable | Type | Default | Required | Description |
|----------|------|---------|----------|-------------|
| `fifo_queue` | `bool` | `false` | No | Boolean designating a FIFO queue |
| `content_based_deduplication` | `bool` | `false` | No | Enables content-based deduplication for FIFO queues |
| `deduplication_scope` | `string` | `queue` | No | Specifies whether message deduplication occurs at the message group or queue level. Valid values: `queue`, `messageGroup` |
| `fifo_throughput_limit` | `string` | `perQueue` | No | Specifies whether the FIFO queue throughput quota applies to the entire queue or per message group. Valid values: `perQueue`, `perMessageGroupId` |

### Dead Letter Queue Configuration

| Variable | Type | Default | Required | Description |
|----------|------|---------|----------|-------------|
| `create_dlq` | `bool` | `false` | No | Create the Dead Letter Queue |
| `dlq_name` | `string` | `""` | No | Name of the Dead Letter Queue |
| `dlq_message_retention_seconds` | `number` | `345600` | No | The number of seconds Amazon SQS retains a message in DLQ |
| `max_receive_count` | `number` | `3` | No | The number of times a message is delivered to the source queue before being moved to the dead-letter queue |

### Encryption Configuration

| Variable | Type | Default | Required | Description |
|----------|------|---------|----------|-------------|
| `sqs_managed_sse_enabled` | `bool` | `true` | No | Enable SQS managed server-side encryption |
| `kms_master_key_id` | `string` | - | Yes | KMS master key ID for SQS encryption |
| `enable_sqs_encryption` | `bool` | `true` | No | Enable server-side encryption for SQS |
| `use_custom_kms_key` | `bool` | `false` | No | Use a customer-managed KMS key for SQS encryption |
| `kms_key_arn` | `string` | `""` | No | KMS key ARN to use for SQS encryption (if use_custom_kms_key is true) |

## Outputs

| Output | Description |
|--------|-------------|
| `sqs_queue_id` | The ID of the primary SQS queue |
| `sqs_queue_arn` | The ARN of the primary SQS queue |
| `sqs_queue_url` | The URL of the primary SQS queue |
| `dlq_queue_id` | The ID of the dead-letter queue (DLQ), if created |
| `dlq_queue_arn` | The ARN of the dead-letter queue (DLQ), if created |
| `dlq_queue_url` | The URL of the dead-letter queue (DLQ), if created |

## FIFO Queue Important Notes

1. **Queue Names**: FIFO queue names must end with `.fifo`. This module automatically appends `.fifo` to both the main queue and DLQ names when `fifo_queue = true`.

2. **Delay Seconds**: FIFO queues do not support delay seconds. The `delay_seconds` parameter must be 0 for FIFO queues.

3. **Message Group ID**: When sending messages to a FIFO queue, you must provide a `MessageGroupId`. Messages with the same `MessageGroupId` are processed in order.

4. **Message Deduplication**: 
   - If `content_based_deduplication = true`, SQS uses a SHA-256 hash of the message body to generate the deduplication ID.
   - If `content_based_deduplication = false`, you must provide a `MessageDeduplicationId` when sending messages.

5. **High-Throughput FIFO**:
   - Set `deduplication_scope = "messageGroup"` and `fifo_throughput_limit = "perMessageGroupId"` for high-throughput FIFO queues.
   - This allows up to 3,000 messages per second per message group ID, with up to 300 API calls per second.

6. **Throughput Limits**:
   - Standard FIFO: 300 API calls per second (3,000 messages per second with batching)
   - High-throughput FIFO: 300 API calls per second per message group ID

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 4.0 |

## Examples

See `examples.tf` for complete usage examples including standard, FIFO, and high-throughput FIFO configurations.
