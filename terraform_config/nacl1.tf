#=======================================
#create Network Access Control List for the vpc and subnets
resource "aws_network_acl" "vpc_nacl1" {
  vpc_id     = aws_vpc.terraform_vpc.id
  subnet_ids = [for subs in aws_subnet.terraform-vpc_subnets : subs.id]
  dynamic "ingress" {
    for_each = var.nacl1_ingress_rules
    content {
      protocol   = ingress.value["protocol"]
      rule_no    = ingress.value["rule_no"]
      action     = ingress.value["action"]
      cidr_block = ingress.value["cidr_block"]
      from_port  = ingress.value["from_port"]
      to_port    = ingress.value["to_port"]
    }
  }

  dynamic "egress" {
    for_each = var.nacl1_egress_rules
    content {
      protocol   = egress.value["protocol"]
      rule_no    = egress.value["rule_no"]
      action     = egress.value["action"]
      cidr_block = egress.value["cidr_block"]
      from_port  = egress.value["from_port"]
      to_port    = egress.value["to_port"]
    }
  }

  tags = var.nacl1-tags
}