resource "aws_sqs_queue" "my_queue" {
  name                        = "my-sqs-queue"
  visibility_timeout_seconds  = 30
  message_retention_seconds   = 86400
  max_message_size            = 262144
  delay_seconds               = 0
  receive_wait_time_seconds   = 0

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dead_letter_queue.arn
    maxReceiveCount     = 5
  })
}

resource "aws_sqs_queue" "dead_letter_queue" {
  name                        = "my-dead-letter-queue"
  visibility_timeout_seconds  = 30
  message_retention_seconds   = 86400
  max_message_size            = 262144
  delay_seconds               = 0
  receive_wait_time_seconds   = 0
}