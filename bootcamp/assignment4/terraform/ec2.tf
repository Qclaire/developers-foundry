
resource "aws_instance" "ec2" {
  for_each      = local.nodes
  ami           = data.aws_ami.ubuntu.id
  key_name      = aws_key_pair.ssh_key.key_name
  instance_type = "t2.micro"
  tags = {
    Name = "k8s-${each.key}"
    Role = each.key
  }
  vpc_security_group_ids = data.aws_security_groups.default_vpc_sgs.ids

}

resource "aws_key_pair" "ssh_key" {
  key_name   = "tech4dev"
  public_key = file("~/.ssh/id_rsa.pub")
}
