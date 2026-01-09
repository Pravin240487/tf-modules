resource "aws_sqs_queue" "dlq" {
  name                      = var.fifo_queue ? "${var.dlq_name}.fifo" : var.dlq_name
  message_retention_seconds = var.dlq_message_retention_seconds
  fifo_queue                = var.fifo_queue
  content_based_deduplication = var.fifo_queue ? var.content_based_deduplication : null
  deduplication_scope       = var.fifo_queue ? var.deduplication_scope : null
  fifo_throughput_limit     = var.fifo_queue ? var.fifo_throughput_limit : null
  tags                      = var.tags
  count                     = var.create_dlq ? 1 : 0
}

resource "aws_sqs_queue" "sqs" {
  name                       = var.fifo_queue ? "${var.sqs_name}.fifo" : var.sqs_name
  delay_seconds              = var.delay_seconds
  max_message_size           = var.max_message_size
  message_retention_seconds  = var.message_retention_seconds
  receive_wait_time_seconds  = var.receive_wait_time_seconds
  visibility_timeout_seconds = var.visibility_timeout_seconds
  fifo_queue                 = var.fifo_queue
  content_based_deduplication = var.fifo_queue ? var.content_based_deduplication : null
  deduplication_scope        = var.fifo_queue ? var.deduplication_scope : null
  fifo_throughput_limit      = var.fifo_queue ? var.fifo_throughput_limit : null
  redrive_policy = var.create_dlq ? jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq[0].arn
    maxReceiveCount     = var.max_receive_count
  }) : null

  # Only set KMS key if provided, otherwise rely on default SQS encryption
  kms_master_key_id = var.kms_master_key_id != null && var.kms_master_key_id != "" ? var.kms_master_key_id : null
  
  tags = var.tags
}
