variable "domain_name" {
  description = "Domain name for Route53"
  type        = string
}

variable "alb_dns_name" {
  description = "ALB DNS Name"
  type        = string
}

variable "alb_zone_id" {
  description = "ALB Zone ID"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}