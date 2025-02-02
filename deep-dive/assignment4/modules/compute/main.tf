resource "aws_security_group" "ec2_sg" {
  name        = "${var.environment}-ec2-sg"
  description = "Security group for EC2 instances"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.alb_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_launch_template" "core_lt" {
  name_prefix   = "${var.environment}-core-lt"
  image_id      = "ami-0c55b159cbfafe1f0" # Amazon Linux 2
  instance_type = "t3.medium"
  key_name      = "your-key-pair"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.ec2_sg.id]
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              EOF
  )
}

resource "aws_autoscaling_group" "core_asg" {
  name                = "${var.environment}-core-asg"
  desired_capacity    = var.instance_count
  max_size            = var.instance_count
  min_size            = var.instance_count
  vpc_zone_identifier = [var.subnet_id]

  launch_template {
    id      = aws_launch_template.core_lt.id
    version = "$Latest"
  }
}

resource "aws_lb" "core_alb" {
  name               = "${var.environment}-core-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = [var.subnet_id]
}

resource "aws_lb_target_group" "core_tg" {
  name     = "${var.environment}-core-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "core_listener" {
  load_balancer_arn = aws_lb.core_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.core_tg.arn
  }
}