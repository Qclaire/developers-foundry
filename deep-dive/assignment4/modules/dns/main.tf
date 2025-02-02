data "aws_route53_zone" "core_domain" {
  name         = var.domain_name
  private_zone = false
}

resource "aws_route53_record" "core_record" {
  zone_id = data.aws_route53_zone.core_domain.zone_id
  name    = var.domain_name
  type    = "A"
  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}