data "aws_caller_identity" "current" {}

locals {
  name = "${var.cb_constants.prefix}-${var.queue_name}${var.fifo_queue == true ? ".fifo" : ""}"

  account_id = data.aws_caller_identity.current.account_id
  _tags = {
    "Name" : local.name
  }
  tags = merge(local._tags, var.tags, var.cb_constants.standard_tags)
}
