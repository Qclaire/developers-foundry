resource "aws_instance" "ec2" {
  ami           = "ami-0e9085e60087ce171"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}