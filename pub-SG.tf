#=====================================
# create security group rules for the public subnets
resource "aws_security_group" "public-subnets_SG" {
  name        = var.pubSG_name
  description = "Defines the set of Alllow rules for the public subnets"
  vpc_id      = aws_vpc.terraform_vpc.id

  dynamic "ingress" {
    for_each = var.inst-sg_ingress_rules
    content {
      description = ingress.value["description"]
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }

  dynamic "egress" {
    for_each = var.inst-sg_egress_rules
    content {
      description = egress.value["description"]
      from_port   = egress.value["from_port"]
      to_port     = egress.value["to_port"]
      protocol    = egress.value["protocol"]
      cidr_blocks = egress.value["cidr_blocks"]
    }
  }

  tags = var.pubSG-tags

  depends_on = [
    aws_vpc.terraform_vpc
  ]
}