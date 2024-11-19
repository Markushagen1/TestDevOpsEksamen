# SQS kø for å sende meldinger til Lambda
resource "aws_sqs_queue" "image_generation_queue_36" {
  name = var.queue_name
  visibility_timeout_seconds = 180
}