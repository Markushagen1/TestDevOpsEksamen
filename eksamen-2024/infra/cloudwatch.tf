resource "aws_sns_topic" "sqs_alarm_topic_36" {
  name = "sqs-alarm-topic_36"
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.sqs_alarm_topic_36.arn
  protocol  = "email"
  endpoint  = var.notification_email
}

resource "aws_cloudwatch_metric_alarm" "oldest_message_age_alarm" {
  alarm_name                = "SQS_OldestMessageAge_Alarm_36"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 1
  metric_name               = "ApproximateAgeOfOldestMessage"
  namespace                 = "AWS/SQS"
  period                    = 60
  statistic                 = "Maximum"
  threshold                 = 30
  alarm_description         = "Trigger alarm når eldste melding i køen er over 2 minutter gammel"
  actions_enabled           = true
  alarm_actions             = [aws_sns_topic.sqs_alarm_topic_36.arn]
  dimensions = {
    QueueName = aws_sqs_queue.image_generation_queue_36.name
  }

  lifecycle {
    prevent_destroy = true
  }
}



