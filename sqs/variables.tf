variable "queue_name" {
  type        = string
  description = "Suffix of the SQS queue"
}

variable "visibility_timeout_seconds" {
  type        = number
  description = "The visibility timeout for the queue. An integer from 0 to 43200 (12 hours). The default for this attribute is 30"
  default     = 30
}

variable "message_retention_seconds" {
  type        = number
  description = "The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days). The default for this attribute is 345600 (4 days)."
  default     = 345600
}

variable "max_message_size" {
  type        = number
  default     = 262144
  description = "The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB). The default for this attribute is 262144 (256 KiB)."
}

variable "delay_seconds" {
  type        = number
  default     = 0
  description = "The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900 (15 minutes). The default for this attribute is 0 seconds."
}

variable "receive_wait_time_seconds" {
  type        = number
  default     = 0
  description = "The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds). The default for this attribute is 0, meaning that the call will return immediately."
}

variable "sqs_managed_sse_enabled" {
  type        = bool
  default     = true
  description = "Boolean to enable server-side encryption (SSE) of message content with SQS-owned encryption keys. Defaults to false. "
}

variable "kms_master_key_id" {
  type        = string
  default     = null
  description = "The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK."
}

variable "fifo_queue" {
  type        = bool
  default     = false
  description = "Boolean designating a FIFO queue. If not set, it defaults to false making it standard."
}

variable "fifo_throughput_limit" {
  type        = string
  default     = "perQueue"
  description = "Specifies whether the FIFO queue throughput quota applies to the entire queue or per message group. Valid values are perQueue (default) and perMessageGroupId."
}

variable "content_based_deduplication" {
  type        = bool
  default     = false
  description = "Enables content-based deduplication for FIFO queues."
}

variable "deduplication_scope" {
  type        = string
  default     = "queue"
  description = "Specifies whether message deduplication occurs at the message group or queue level. Valid values are messageGroup and queue (default)."
}

variable "tags" {
  type        = any
  default     = {}
  description = "The tags that needs to be associated."
}

variable "allowed_arns" {
  type        = list(string)
  default     = null
  description = "List of ARNs to give the queue access to."
}

variable "dead_letter_queue_arn" {
  type        = string
  default     = null
  description = "The deadletter queue associated with this queue. Defaults to null (No Deadletter)"
}

variable "dead_letter_queue_max_receive_count" {
  type        = number
  default     = 10
  description = "The number of times that a message can be received before being sent to a dead-letter queue, set Maximum receives to a value between 1 and 1,000. Defaults to 10."
}

variable "enforce_tls" {
  type        = string
  default     = "true"
  description = "Whether to enforce TLS on SQS queue."
}
