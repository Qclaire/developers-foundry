resource "aws_launch_template" "lt" {
 name = "${var.top-level-prefix}-lt"
instance_type = var.instance-type
iam_instance_profile {
  name = aws_iam_instance_profile.iam-ip.name
}

  credit_specification {
    cpu_credits = "standard"
  }

  disable_api_stop        = false
  disable_api_termination = false

  ebs_optimized = true

  image_id = data.aws_ami.ubuntu.id

  instance_initiated_shutdown_behavior = "terminate"


  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  monitoring {
    enabled = false
  }

  # network_interfaces {
  #   associate_public_ip_address = true
  # }

  placement {
    availability_zone = data.aws_availability_zones.available.names[0]
  }

  vpc_security_group_ids = [aws_security_group.sg_instance.id]

  user_data = filebase64("${path.module}/launch.sh")
}