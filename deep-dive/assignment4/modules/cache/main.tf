resource "aws_security_group" "redis_sg" {
  name        = "${var.environment}-redis-sg"
  description = "Security group for Redis"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = [var.ec2_sg_id]
  }
}

resource "aws_elasticache_subnet_group" "core_redis_subnet" {
  name       = "${var.environment}-redis-subnet"
  subnet_ids = var.subnet_ids
}

resource "aws_elasticache_cluster" "core_redis" {
  cluster_id           = "${var.environment}-core-redis"
  engine               = "redis"
  node_type            = var.redis_config.node_type
  num_cache_nodes      = 1
  parameter_group_name = "default.redis5.0"
  engine_version       = "5.0.6"
  port                 = 6379
  security_group_ids   = [aws_security_group.redis_sg.id]
  subnet_group_name    = aws_elasticache_subnet_group.core_redis_subnet.name
}