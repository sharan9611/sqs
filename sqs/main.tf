resource "aws_sqs_queue" "queue" {
  name = local.name

  visibility_timeout_seconds = var.visibility_timeout_seconds
  message_retention_seconds  = var.message_retention_seconds
  max_message_size           = var.max_message_size
  delay_seconds              = var.delay_seconds
  receive_wait_time_seconds  = var.receive_wait_time_seconds

  # FIFO and Deduplication
  fifo_queue            = var.fifo_queue
  fifo_throughput_limit = var.fifo_queue == true ? var.fifo_throughput_limit : null

  content_based_deduplication = var.fifo_queue == true ? var.content_based_deduplication : null
  deduplication_scope         = var.fifo_queue == true ? var.deduplication_scope : null

  redrive_policy = var.dead_letter_queue_arn == null ? null : jsonencode({
    deadLetterTargetArn = var.dead_letter_queue_arn,
    maxReceiveCount     = var.dead_letter_queue_max_receive_count
  })

  sqs_managed_sse_enabled           = var.sqs_managed_sse_enabled
  kms_master_key_id                 = var.kms_master_key_id

  tags = local.tags
}

resource "aws_sqs_queue_policy" "queue" {
  queue_url = aws_sqs_queue.queue.id
  policy    = data.aws_iam_policy_document.queue.json
}

data "aws_iam_policy_document" "queue" {
  statement {
    effect    = "Allow"
    resources = [aws_sqs_queue.queue.arn]
    actions = [
      "sqs:ChangeMessageVisibility",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:ListQueueTags",
      "sqs:ReceiveMessage",
      "sqs:SendMessage",
    ]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = [ var.enforce_tls ] 
    }

    principals {
      type        = "AWS"
      identifiers = var.allowed_arns == null ? [local.account_id] : var.allowed_arns
    }
  }
}
