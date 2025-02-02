resource "aws_iam_role" "ec2_logging_role" {
  name = "${var.top-level-prefix}-logging-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "cloudwatch_logs_policy" {
  name        = "${var.top-level-prefix}-cloudwatch-logs-policy"
  description = "Policy for EC2 to log to CloudWatch"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      Effect   = "Allow",
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach_cloudwatch_policy" {
  role       = aws_iam_role.ec2_logging_role.name
  policy_arn = aws_iam_policy.cloudwatch_logs_policy.arn
}

resource "aws_iam_instance_profile" "iam-ip" {
  name = "${var.top-level-prefix}-instance-policy"
  role = aws_iam_role.ec2_logging_role.name
}