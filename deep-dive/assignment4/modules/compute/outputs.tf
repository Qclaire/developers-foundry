output "ec2_sg_id" {
  description = "EC2 Security Group ID"
  value       = aws_security_group.ec2_sg.id
}

output "alb_dns_name" {
  description = "ALB DNS Name"
  value       = aws_lb.core_alb.dns_name
}

output "alb_zone_id" {
  description = "ALB Zone ID"
  value       = aws_lb.core_alb.zone_id
}