output "db_endpoint" {
  description = "RDS Endpoint"
  value       = aws_db_instance.core_db.endpoint
}