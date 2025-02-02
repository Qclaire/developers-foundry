output "dns_name" {
  description = "DNS Name"
  value       = aws_route53_record.core_record.name
}