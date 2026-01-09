variable "dlq_name" {
  description = "Name of the Dead Letter Queue"
  type        = string
  default     = ""

}
variable "dlq_message_retention_seconds" {
  description = "The number of seconds Amazon SQS retains a message"
  type        = number
  default     = 345600

}
variable "create_dlq" {
  description = "Create the Dead Letter Queue"
  type        = bool
  default     = false

}
variable "sqs_name" {
  description = "Name of the SQS Queue"
  type        = string

}
variable "delay_seconds" {
  description = "The time in seconds that the delivery of all messages in the queue will be delayed. Must be 0 for FIFO queues."
  type        = number
  default     = 90
}
variable "max_message_size" {
  description = "The limit of how many bytes a message can contain before Amazon SQS rejects it"
  type        = number
  default     = 262144

}
variable "message_retention_seconds" {
  description = "The number of seconds Amazon SQS retains a message"
  type        = number
  default     = 86400

}
variable "receive_wait_time_seconds" {
  description = "The time for which a ReceiveMessage call will wait for a message to arrive"
  type        = number
  default     = 5

}
variable "visibility_timeout_seconds" {
  description = "The visibility timeout for the queue"
  type        = number
  default     = 30

}
variable "max_receive_count" {
  description = "The number of times a message is delivered to the source queue before being moved to the dead-letter queue"
  type        = number
  default     = 3

}
variable "tags" {
  description = "Tags for the SQS Queue"
  type        = map(string)

}
variable "enable_sqs_encryption" {
  description = "Enable server-side encryption for SQS"
  type        = bool
  default     = true
}

variable "use_custom_kms_key" {
  description = "Use a customer-managed KMS key for SQS encryption"
  type        = bool
  default     = false
}

variable "kms_key_arn" {
  description = "KMS key ARN to use for SQS encryption (if use_custom_kms_key is true)"
  type        = string
  default     = ""
}
variable "kms_master_key_id" {
  description = "KMS master key ID for SNS topic encryption"
  type        = string
  default     = ""
}

# variable "sqs_managed_sse_enabled" {
#   description = "Enable SQS managed server-side encryption"
#   type        = bool
#   default     = true
# }

variable "fifo_queue" {
  description = "Boolean designating a FIFO queue"
  type        = bool
  default     = false
}

variable "content_based_deduplication" {
  description = "Enables content-based deduplication for FIFO queues"
  type        = bool
  default     = false
}

variable "deduplication_scope" {
  description = "Specifies whether message deduplication occurs at the message group or queue level"
  type        = string
  default     = "queue"
  validation {
    condition     = contains(["queue", "messageGroup"], var.deduplication_scope)
    error_message = "deduplication_scope must be either 'queue' or 'messageGroup'."
  }
}

variable "fifo_throughput_limit" {
  description = "Specifies whether the FIFO queue throughput quota applies to the entire queue or per message group"
  type        = string
  default     = "perQueue"
  validation {
    condition     = contains(["perQueue", "perMessageGroupId"], var.fifo_throughput_limit)
    error_message = "fifo_throughput_limit must be either 'perQueue' or 'perMessageGroupId'."
  }
}