# data "aws_route53_zone" "hosted_zone" {
#   name         = var.hosted_zone_var
#   private_zone = false
# }
# resource "aws_route53_record" "be" {
#   zone_id = data.aws_route53_zone.hosted_zone.zone_id
#   name    = var.domain_name_sub
#   type    = "A"

#   alias {
#     name                   = var.lb_dns_name
#     zone_id                = var.lb_zone_id
#     evaluate_target_health = true
#   }
# }