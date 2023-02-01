#===========================================
# Create an Application Load Balancer for application servers
resource "aws_lb" "tf-app_LB" {
  name                       = var.app-lb_values["appLB_values"]["name"]
  internal                   = var.app-lb_values["appLB_values"]["internal"]
  load_balancer_type         = var.app-lb_values["appLB_values"]["lb_type"]
  security_groups            = [aws_security_group.app_LB_SG.id]
  subnets                    = [for subs in aws_subnet.terraform-vpc_subnets : subs.id]
  enable_deletion_protection = var.app-lb_values["appLB_values"]["del_protect"]
  tags                       = var.app-lb_values["appLB_values"]["tags"]
}

#=====================================
# create security group rules for the application load balancer
resource "aws_security_group" "app_LB_SG" {
  name        = var.lb_SG_values["SG1_values"]["name"]
  description = "Defines the set of rules for the load balancer"
  vpc_id      = aws_vpc.terraform_vpc.id

  dynamic "ingress" {
    for_each = var.LB1-sg_ingress_rules
    content {
      description = ingress.value["description"]
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }

  dynamic "egress" {
    for_each = var.LB1-sg_egress_rules
    content {
      description = egress.value["description"]
      from_port   = egress.value["from_port"]
      to_port     = egress.value["to_port"]
      protocol    = egress.value["protocol"]
      cidr_blocks = egress.value["cidr_blocks"]
    }
  }

  tags = var.lb_SG_values["SG1_values"]["tags"]
}