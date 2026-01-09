resource "aws_sns_topic" "sns" {
  name              = var.name
  delivery_policy   = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false,
    "defaultRequestPolicy": {
      "headerContentType": "text/plain; charset=UTF-8"
    }
  }
}
EOF
  kms_master_key_id = var.kms_master_key_id
}
resource "aws_sns_topic_subscription" "aws_sns_topic_subscription" {
  count     = length(var.endpoint)
  topic_arn = aws_sns_topic.sns.arn
  protocol  = var.protocol
  endpoint  = var.endpoint[count.index]
}
