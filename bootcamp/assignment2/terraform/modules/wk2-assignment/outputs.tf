output "availability-zones" {
    description = "Availability zones"
    value = data.aws_availability_zones.available.names
  
}

output "ami" {
    value = data.aws_ami.ubuntu.id
}

output "lb-dns" {
    value = aws_lb.lb.dns_name
}