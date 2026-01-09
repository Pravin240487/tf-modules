### Alb Security Group

module "aws_security_group" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/network-security-group/security-group/1.0.0"

  name        = var.load_balancer_name
  description = var.security_group_description
  vpc_id      = var.vpc_id
  tags        = var.tags
}

module "aws_vpc_security_group_ingress_rule" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/network-security-group/ingress-rule/1.0.0"

  security_group_id = module.aws_security_group.id
  name              = var.ingress_rule_name
  description       = var.ingress_rule_description
  cidr_ipv4         = var.ingress_rule_cidr_ipv4
  from_port         = var.ingress_rule_from_port
  ip_protocol       = var.ingress_rule_ip_protocol
  to_port           = var.ingress_rule_to_port
  tags              = var.tags
}

module "aws_vpc_security_group_ingress_rule_http" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/network-security-group/ingress-rule/1.0.0"

  security_group_id = module.aws_security_group.id
  name              = var.ingress_rule_http_name
  description       = var.ingress_rule_http_description
  cidr_ipv4         = var.ingress_rule_http_cidr_ipv4
  from_port         = var.ingress_rule_http_from_port
  ip_protocol       = var.ingress_rule_http_ip_protocol
  to_port           = var.ingress_rule_http_to_port
  tags              = var.tags
}

module "aws_vpc_security_group_egress_rule" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//network/network-security-group/egress-rule/1.0.0"

  security_group_id = module.aws_security_group.id
  name              = var.egress_rule_name
  description       = var.egress_rule_description
  cidr_ipv4         = var.egress_rule_cidr_ipv4
  ip_protocol       = var.egress_rule_ip_protocol
  tags              = var.tags
}

### ALB

resource "aws_lb" "this" {
  name               = var.load_balancer_name
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = [module.aws_security_group.id]
  subnets            = var.subnets

  client_keep_alive = var.client_keep_alive
  idle_timeout      = var.idle_timeout

  drop_invalid_header_fields = true


  enable_deletion_protection = var.enable_deletion_protection

  dynamic "access_logs" {
    for_each = var.enable_access_logs ? [1] : []
    content {
      bucket  = var.access_logs_s3_bucket_id
      prefix  = var.log_prefix
      enabled = var.enable_access_logs
    }
  }

  tags = var.tags
}

### ALB HTTP Listener

resource "aws_lb_listener" "this_http" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  tags = var.tags
}

### ALB HTTPS Listener

resource "aws_lb_listener" "this_https" {
  load_balancer_arn = aws_lb.this.arn
  port              = "443"
  protocol          = "HTTPS"

  certificate_arn = var.certificate_arn
  ssl_policy      = var.ssl_policy

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Unable to Process Your Request"
      status_code  = "503"
    }
  }

  tags = var.tags
}

### WAF Association

module "waf_regional" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/waf-association/1.0.0"

  count  = var.enable_waf ? 1 : 0
  
  resource_arn = aws_lb.this.arn
  web_acl_arn  = var.web_acl_arn
}
