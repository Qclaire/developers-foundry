# EC2 Instance configuration
resource "aws_instance" "ec2" {
  ami           = var.ami-id
  instance_type = "t2.micro"
  
  # Add security groups at instance level since they're not in launch template
  vpc_security_group_ids = data.aws_security_groups.default_vpc_sgs.ids
  
  # Modified launch template reference to ensure no network conflicts
  launch_template {
    id      = aws_launch_template.launch-template.id
    version = "$Latest"
  }
}

# Launch template configuration
resource "aws_launch_template" "launch-template" {
  name_prefix = "${var.top-level-prefix}-"
  instance_type = var.instance-type
  
  disable_api_stop        = false
  disable_api_termination = false

  ebs_optimized = true

  image_id = data.aws_ami.ubuntu.id

  instance_initiated_shutdown_behavior = "terminate"

  monitoring {
    enabled = false
  }

  placement {
    availability_zone = var.region
  }

  # Remove vpc_security_group_ids from here since we're using them in the instance
  # vpc_security_group_ids = data.aws_security_groups.default_vpc_sgs.ids

  user_data = filebase64("./modules/wk2-assignment/launch.sh")
}

# Your existing data sources remain the same
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name = "architecture"
    values = ["x86_64"]
  }
  filter {
    name = "image-id"
    values = [var.ami-id]
  }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_security_groups" "default_vpc_sgs" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_security_group" "sg_details" {
  count = length(data.aws_security_groups.default_vpc_sgs.ids)
  id    = data.aws_security_groups.default_vpc_sgs.ids[count.index]
}

# Your existing outputs
output "public_ip" {
  value = aws_instance.ec2.public_ip
}

output "public_dns" {
  value = aws_instance.ec2.public_dns
}