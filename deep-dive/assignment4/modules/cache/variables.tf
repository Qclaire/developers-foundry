variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs for Elasticache"
  type        = list(string)
}

variable "redis_config" {
  description = "Redis configuration"
  type = object({
    auth_token = string
    node_type  = string
  })
  sensitive = true
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "ec2_sg_id" {
  description = "EC2 Security Group ID"
  type        = string
}