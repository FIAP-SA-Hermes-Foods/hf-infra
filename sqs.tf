resource "aws_sqs_queue" "example" {
  name                      = var.queue_name
  delay_seconds             = 0
  max_message_size          = 262144
  message_retention_seconds = 86400 # 1 dia (reduza se possível)
  receive_wait_time_seconds = 0
}

output "sqs_queue_url" {
  value = aws_sqs_queue.example.id
}
