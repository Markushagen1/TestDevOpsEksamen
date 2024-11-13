# variabler for å kunne endre veriende her istedenfor i main
variable "bucket_name" {
  description = "Name of the S3 bucket for storing generated images"
  type        = string
  default     = "pgr301-couch-explorers"
}

variable "queue_name" {
  description = "Name of the SQS queue for image generation requests"
  type        = string
  default     = "image-generation-queue-36"
}

variable "lambda_timeout" {
  description = "Timeout for the Lambda function"
  type        = number
  default     = 30
}


