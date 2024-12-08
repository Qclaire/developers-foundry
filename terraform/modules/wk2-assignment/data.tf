data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }
  filter {
    name = "image-id"
    values = [ var.ami-id ]
  }
}