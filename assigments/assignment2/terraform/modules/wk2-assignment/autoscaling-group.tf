resource "aws_autoscaling_group" "asg" {
  name                 = "asg"
  min_size             = 1
  max_size             = 3
  desired_capacity     = 1
  vpc_zone_identifier  = module.vpc.public_subnets
  health_check_type    = "ELB"
  wait_for_elb_capacity = 1
  # load_balancers = [ aws_lb.lb.name ]

  launch_template {
    name = aws_launch_template.lt.name
    version= "$Latest"
  }
  

  tag {
    key                 = "Name"
    value               = "${var.top-level-prefix}-asg"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "ata" {
  autoscaling_group_name = aws_autoscaling_group.asg.name
  lb_target_group_arn   = aws_lb_target_group.tg.arn
}