resource "aws_lb_listener_rule" "this" {
  listener_arn = var.listener_arn
  priority     = var.priority

  action {
    type = var.action_type

    dynamic "forward" {
      for_each = var.action_type == "forward" ? [1] : []
      content {
        target_group {
          arn = var.target_group_arn
        }

        dynamic "stickiness" {
          for_each = var.stickiness_enabled ? [1] : []
          content {
            enabled  = var.stickiness_enabled
            duration = var.stickiness_duration
          }
        }
      }
    }

    dynamic "redirect" {
      for_each = var.action_type == "redirect" ? [1] : []
      content {
        host        = lookup(var.redirect_config, "host", "#{host}")
        path        = lookup(var.redirect_config, "path", "/#{path}")
        port        = lookup(var.redirect_config, "port", "443")
        protocol    = lookup(var.redirect_config, "protocol", "HTTPS")
        query       = lookup(var.redirect_config, "query", "#{query}")
        status_code = lookup(var.redirect_config, "status_code", "HTTP_301")
      }
    }
  }

  dynamic "condition" {
    for_each = length(var.path_pattern) > 0 ? [1] : []
    content {
      path_pattern {
        values = var.path_pattern
      }
    }
  }

  dynamic "condition" {
    for_each = length(var.host_header) > 0 ? [1] : []
    content {
      host_header {
        values = var.host_header
      }
    }
  }

  tags = merge(
    {
      "Name" = var.aws_lb_listener_rule_name
    },
    var.tags
  )
}
