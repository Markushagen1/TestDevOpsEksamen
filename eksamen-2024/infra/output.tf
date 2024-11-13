# output for lambda funksjonens ARN
output "lambda_function_arn" {
  description = "ARN for the image generator Lambda function"
  value       = aws_lambda_function.image_generator.arn
}

# en output for sqs køens URL
output "sqs_queue_url" {
  description = "URL for the image generation SQS queue"
  value       = aws_sqs_queue.image_generation_queue_36.url
}

# Output for S3-bucket name, her filene lagres
output "s3_bucket_name" {
  description = "Name of the S3 bucket where Lambda stores generated images"
  value       = var.bucket_name
}
