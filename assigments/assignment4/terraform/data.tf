data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "name"
    values = ["*ubuntu*-24.04-amd64-server*"]
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