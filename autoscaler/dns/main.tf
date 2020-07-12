resource "aws_route53_record" "ctf_dns" {
  zone_id = var.zone_id
  name    = var.dns_name
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}

