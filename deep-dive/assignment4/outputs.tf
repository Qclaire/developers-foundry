output "alb_dns_name" {
  description = "ALB DNS name"
  value       = module.compute.alb_dns_name
}

output "db_endpoint" {
  description = "RDS endpoint"
  value       = module.database.db_endpoint
}

output "redis_endpoint" {
  description = "Elasticache endpoint"
  value       = module.cache.redis_endpoint
}

output "website_url" {
  description = "Core banking application URL"
  value       = "https://${var.domain_name}"
}