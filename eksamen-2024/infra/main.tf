# Lambda funksjon for å prosessere bilde generasjon
resource "aws_lambda_function" "image_generator" {
  function_name = "image-generator-lambda-36"
  handler       = "lambda_sqs.lambda_handler"
  runtime       = "python3.8"
  filename      = "${path.module}/lambda_sqs36.zip"
  role          = aws_iam_role.lambda_role.arn
  timeout       = 30
  environment {
    variables = {
      BUCKET_NAME = var.bucket_name
      QUEUE_URL   = aws_sqs_queue.image_generation_queue_36.url
    }
  }
}


# Mapping for å utløse Lambda fra SQS
resource "aws_lambda_event_source_mapping" "sqs_to_lambda" {
  event_source_arn = aws_sqs_queue.image_generation_queue_36.arn
  function_name    = aws_lambda_function.image_generator.arn
  batch_size       = 5
  enabled          = true
}

