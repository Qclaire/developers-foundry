variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "prod"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "instance_count" {
  description = "Number of EC2 instances"
  type        = number
  default     = 25
}

variable "db_credentials" {
  description = "Database credentials"
  type = object({
    username = string
    password = string
  })
  sensitive = true
}

variable "redis_config" {
  description = "Redis configuration"
  type = object({
    auth_token = string
    node_type  = string
  })
  sensitive = true
}

variable "domain_name" {
  description = "Domain name for Route53"
  type        = string
  default     = "corebank.com"
}