aws_region = "us-east-1"
environment = "prod"
instance_count = 25

db_credentials = {
  username = "admin"
  password = "securepassword123"
}

redis_config = {
  auth_token = "redis-auth-token"
  node_type  = "cache.m4.large"
}

domain_name = "corebank.com"