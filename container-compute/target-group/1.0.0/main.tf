resource "aws_lb_target_group" "this" {
  name        = var.target_group_name
  port        = var.target_group_port
  protocol    = var.protocol
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = var.healthy_threshold
    interval            = var.interval
    matcher             = var.matcher
    path                = var.path
    port                = "traffic-port"
    protocol            = var.protocol
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.timeout
  }

  dynamic "stickiness" {
    for_each = var.enable_stickiness ? [1] : []
    content {
      type            = var.stickiness_type
      enabled         = true
      cookie_duration = var.stickiness_cookie_duration
    }
  }

  tags = var.tags
}
