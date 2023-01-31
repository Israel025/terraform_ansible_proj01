#===================================
# Create target group for the load balancer
resource "aws_lb_target_group" "appLB_TG" {
  vpc_id      = aws_vpc.terraform_vpc.id
  name        = var.appLB_TG_values["TG1-values"]["name"]
  port        = var.appLB_TG_values["TG1-values"]["port"]
  protocol    = var.appLB_TG_values["TG1-values"]["protocol"]
  target_type = var.appLB_TG_values["TG1-values"]["target_type"]

  health_check {
    healthy_threshold   = var.appLB_TG_values["TG1-values"]["healthy_thresh"]
    interval            = var.appLB_TG_values["TG1-values"]["interval"]
    port                = var.appLB_TG_values["TG1-values"]["port"]
    path                = var.appLB_TG_values["TG1-values"]["path"]
    protocol            = var.appLB_TG_values["TG1-values"]["protocol"]
    timeout             = var.appLB_TG_values["TG1-values"]["timeout"]
    unhealthy_threshold = var.appLB_TG_values["TG1-values"]["unhealthy_thresh"]
    matcher             = var.appLB_TG_values["TG1-values"]["matcher"]
  }
}

#=========================================
# Attching the Target group to the load balancer
resource "aws_lb_target_group_attachment" "LB-TG_attach" {
  target_group_arn = aws_lb_target_group.appLB_TG.arn
  for_each         = aws_instance.web_servers
  target_id        = each.value["id"]
  port             = var.LB-TG_attach_port
}