resource "aws_launch_configuration" "launch-config" {
  name_prefix     = "${var.top-level-prefix}-"
  image_id        = data.aws_ami.ubuntu.id
  instance_type   = var.instance-type
  user_data       = file("user-data.sh")
  security_groups = [aws_security_group.terramino_instance.id]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "as" {
  name                 = "autoscaling"
  min_size             = 1
  max_size             = 3
  desired_capacity     = 1
  launch_configuration = aws_launch_configuration.launch-config.name
  vpc_zone_identifier  = module.vpc.public_subnets

  health_check_type    = "ELB"

  tag {
    key                 = "Name"
    value               = "${var.top-level-prefix}-autoscaling"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "terramino" {
  autoscaling_group_name = aws_autoscaling_group.as.id
  alb_target_group_arn   = aws_lb_target_group.tg.arn
}