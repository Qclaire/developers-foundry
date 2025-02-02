output "redis_endpoint" {
  description = "Redis Endpoint"
  value       = aws_elasticache_cluster.core_redis.cache_nodes[0].address
}