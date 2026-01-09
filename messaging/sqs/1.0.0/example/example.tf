provider "aws" {
  region = "us-east-1"
}

# Example 1: Standard SQS Queue
module "standard_sqs_queue" {
  source = "./path-to-your-module" # Update with actual module path

  sqs_name                   = "order-processing-queue"
  delay_seconds              = 60
  max_message_size           = 262144
  message_retention_seconds  = 86400
  receive_wait_time_seconds  = 10
  visibility_timeout_seconds = 45

  sqs_managed_sse_enabled = true
  enable_sqs_encryption   = true
  use_custom_kms_key      = true
  kms_key_arn             = "arn:aws:kms:us-east-1:123456789012:key/abcd1234"
  kms_master_key_id       = "alias/sqs/kms"

  create_dlq                    = true
  dlq_name                      = "order-processing-dlq"
  dlq_message_retention_seconds = 345600
  max_receive_count             = 4

  tags = {
    Environment = "prod"
    Owner       = "order-team"
  }
}

# Example 2: FIFO SQS Queue with Content-Based Deduplication
module "fifo_sqs_queue" {
  source = "./path-to-your-module" # Update with actual module path

  sqs_name                   = "order-processing-queue"
  max_message_size           = 262144
  message_retention_seconds  = 86400
  receive_wait_time_seconds  = 10
  visibility_timeout_seconds = 45

  # FIFO Configuration
  fifo_queue                  = true
  content_based_deduplication = true
  deduplication_scope         = "messageGroup"
  fifo_throughput_limit       = "perMessageGroupId"

  sqs_managed_sse_enabled = true
  kms_master_key_id       = "alias/aws/sqs"

  create_dlq                    = true
  dlq_name                      = "order-processing-dlq"
  dlq_message_retention_seconds = 345600
  max_receive_count             = 3

  tags = {
    Environment = "prod"
    Owner       = "order-team"
    QueueType   = "FIFO"
  }
}

# Example 3: FIFO SQS Queue without Content-Based Deduplication
module "fifo_sqs_queue_no_dedup" {
  source = "./path-to-your-module" # Update with actual module path

  sqs_name                   = "payment-processing-queue"
  max_message_size           = 262144
  message_retention_seconds  = 86400
  receive_wait_time_seconds  = 20
  visibility_timeout_seconds = 30

  # FIFO Configuration
  fifo_queue                  = true
  content_based_deduplication = false
  deduplication_scope         = "queue"
  fifo_throughput_limit       = "perQueue"

  sqs_managed_sse_enabled = true
  kms_master_key_id       = "alias/aws/sqs"

  create_dlq                    = true
  dlq_name                      = "payment-processing-dlq"
  dlq_message_retention_seconds = 1209600 # 14 days
  max_receive_count             = 5

  tags = {
    Environment = "prod"
    Owner       = "payment-team"
    QueueType   = "FIFO"
  }
}

# Example 4: High-Throughput FIFO Queue
module "high_throughput_fifo_sqs" {
  source = "./path-to-your-module" # Update with actual module path

  sqs_name                   = "high-volume-processing-queue"
  max_message_size           = 262144
  message_retention_seconds  = 345600 # 4 days
  receive_wait_time_seconds  = 0
  visibility_timeout_seconds = 60

  # FIFO Configuration for high throughput
  fifo_queue                  = true
  content_based_deduplication = true
  deduplication_scope         = "messageGroup"
  fifo_throughput_limit       = "perMessageGroupId"

  sqs_managed_sse_enabled = true
  kms_master_key_id       = "alias/aws/sqs"

  create_dlq                    = false # No DLQ for this example

  tags = {
    Environment = "prod"
    Owner       = "data-team"
    QueueType   = "FIFO-HighThroughput"
  }
}
