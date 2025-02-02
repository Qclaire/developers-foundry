variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs for RDS"
  type        = list(string)
}

variable "db_credentials" {
  description = "Database credentials"
  type = object({
    username = string
    password = string
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