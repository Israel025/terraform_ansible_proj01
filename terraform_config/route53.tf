#=================================
# Setting up hosted zone
resource "aws_route53_zone" "domain_HZ" {
  name = var.route53_zone_values["HZ1_values"]["domain_name"]
  tags = var.route53_zone_values.HZ1_values.tags
}

#==================================
# Creating an A record set in route 53
resource "aws_route53_record" "alias_domain" {
  zone_id = aws_route53_zone.domain_HZ.zone_id
  name    = "terraform-test.${var.route53_zone_values["HZ1_values"]["domain_name"]}"
  type    = var.route53-A_record_values["record1_values"]["record_type"]

  alias {
    name                   = aws_lb.tf-app_LB.dns_name
    zone_id                = aws_lb.tf-app_LB.zone_id
    evaluate_target_health = var.route53-A_record_values["record1_values"]["check_health"]
  }
}