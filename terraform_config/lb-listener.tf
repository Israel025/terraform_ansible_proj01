#===========================================
# Listener resource for the Application load balancer
resource "aws_lb_listener" "app-LB_listens" {
  load_balancer_arn = aws_lb.tf-app_LB.arn
  port              = var.LB-listens_values["listener1-values"]["port"]
  protocol          = var.LB-listens_values["listener1-values"]["protocol"]

  default_action {
    type             = var.LB-listens_values["listener1-values"]["type"]
    target_group_arn = aws_lb_target_group.appLB_TG.arn
  }
}

#===========================================
# Listening rule resource for the Application load balancer listener
resource "aws_lb_listener_rule" "app-LB-listen-rule" {
  listener_arn = aws_lb_listener.app-LB_listens.arn
  priority     = var.LB-listener_rules["listener1-rules_values"]["priority"]

  action {
    type             = var.LB-listener_rules["listener1-rules_values"]["type"]
    target_group_arn = aws_lb_target_group.appLB_TG.arn
  }

  condition {
    path_pattern {
      values = var.LB-listener_rules["listener1-rules_values"]["pattern_values"]
    }
  }
}