resource "aws_cloudwatch_log_group" "example" {
  name              = "${var.top-level-prefix}-logs"
  retention_in_days = 30
}
