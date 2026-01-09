locals {
  envoy_config = var.envoy_config != null && var.envoy_config != "" ? var.envoy_config : <<-EOC
    admin:
      address:
        socket_address:
          address: 127.0.0.1
          port_value: ${var.admin_port}

    static_resources:
      listeners:
      - name: http_proxy_listener
        address:
          socket_address:
            address: 0.0.0.0
            port_value: ${var.listener_port}
        filter_chains:
        - transport_socket:
            name: envoy.transport_sockets.tls
            typed_config:
              "@type": type.googleapis.com/envoy.extensions.transport_sockets.tls.v3.DownstreamTlsContext
              common_tls_context:
                tls_certificates:
                - certificate_chain:
                    filename: "/etc/envoy/certs/server.crt"
                  private_key:
                    filename: "/etc/envoy/certs/server.key"
                validation_context:
                  trusted_ca:
                    filename: "/etc/envoy/certs/ca.crt"
              require_client_certificate: true
          filters:
          - name: envoy.filters.network.http_connection_manager
            typed_config:
              "@type": type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.HttpConnectionManager
              stat_prefix: http_proxy
              codec_type: AUTO
              route_config:
                name: local_route
                virtual_hosts:
                - name: api_service
                  domains: ["*"]
                  routes:
                  - match:
                      prefix: "/"
                    route:
                      cluster: api_cluster
                      host_rewrite_literal: ${var.upstream_host}
              http_filters:
              - name: envoy.filters.http.router
                typed_config:
                  "@type": type.googleapis.com/envoy.extensions.filters.http.router.v3.Router
              access_log:
              - name: envoy.access_loggers.file
                typed_config:
                  "@type": type.googleapis.com/envoy.extensions.access_loggers.file.v3.FileAccessLog
                  path: "/var/log/envoy/access.log"

      - name: health_listener
        address:
          socket_address:
            address: 0.0.0.0
            port_value: ${var.healthcheck_port}
        filter_chains:
        - filters:
          - name: envoy.filters.network.http_connection_manager
            typed_config:
              "@type": type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.HttpConnectionManager
              stat_prefix: health
              codec_type: AUTO
              route_config:
                name: health_route
                virtual_hosts:
                - name: health_service
                  domains: ["*"]
                  routes:
                  - match:
                      path: "/health"
                    direct_response:
                      status: 200
                      body:
                        inline_string: "OK"
              http_filters:
              - name: envoy.filters.http.router
                typed_config:
                  "@type": type.googleapis.com/envoy.extensions.filters.http.router.v3.Router

      clusters:
      - name: api_cluster
        type: STRICT_DNS
        connect_timeout: 5s
        lb_policy: ROUND_ROBIN
        dns_lookup_family: V4_ONLY
        load_assignment:
          cluster_name: api_cluster
          endpoints:
          - lb_endpoints:
            - endpoint:
                address:
                  socket_address:
                    address: ${var.upstream_host}
                    port_value: ${var.upstream_port}
        transport_socket:
          name: envoy.transport_sockets.tls
          typed_config:
            "@type": type.googleapis.com/envoy.extensions.transport_sockets.tls.v3.UpstreamTlsContext
            # Envoy uses this SNI for TLS handshake and hostname validation.
            sni: "${var.upstream_host}"
            common_tls_context:
              validation_context:
                # Use system trust store for public CA validation
                trusted_ca:
                  filename: "/etc/ssl/certs/ca-certificates.crt"
  EOC
}

# ---------- Security Group for Envoy EC2 ----------

resource "aws_security_group" "envoy_sg" {
  name        = "${var.envoy_instance_name}-sg"
  description = "Security group for Envoy EC2"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  ingress {
    description     = "Envoy downstream TLS from NLB"
    from_port       = var.listener_port
    to_port         = var.listener_port
    protocol        = "tcp"
    security_groups = [aws_security_group.nlb_sg.id]
  }

  ingress {
    description     = "Envoy health endpoint from NLB"
    from_port       = var.healthcheck_port
    to_port         = var.healthcheck_port
    protocol        = "tcp"
    security_groups = [aws_security_group.nlb_sg.id]
  }

  ingress {
    description = "Envoy downstream TLS from VPC (direct access)"
    from_port   = var.listener_port
    to_port     = var.listener_port
    protocol    = "tcp"
    cidr_blocks =  var.vpc_cidr_blocks
  }

  ingress {
    description = "Envoy health endpoint from VPC (direct access)"
    from_port   = var.healthcheck_port
    to_port     = var.healthcheck_port
    protocol    = "tcp"
    cidr_blocks = var.vpc_cidr_blocks
  }

  ingress {
    description = "Envoy admin"
    from_port   = var.admin_port
    to_port     = var.admin_port
    protocol    = "tcp"
    cidr_blocks = [var.allowed_admin_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.egress_cidr_blocks
  }

  tags = merge(
    {
      Name = "${var.envoy_instance_name}-sg"
    },
    var.tags
  )
}

# ---------- IAM Role for CloudWatch Logs ----------

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_iam_policy_document" "envoy_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

module "envoy_iam_role" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/iam-role/1.0.0"

  iam_role_name      = "${var.envoy_instance_name}-iam-role"
  assume_role_policy = data.aws_iam_policy_document.envoy_assume_role.json
  tags               = var.tags
}

locals {
  cloudwatch_log_group_arn = var.cloudwatch_log_group_name != null ? "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:${var.cloudwatch_log_group_name}:*" : "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:*"
  cloudwatch_log_stream_arn = var.cloudwatch_log_group_name != null ? "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:${var.cloudwatch_log_group_name}:log-stream:*" : "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:*:log-stream:*"
}

module "envoy_cloudwatch_policy" {
  source = "s3::https://qs-tf-modules.s3.eu-central-1.amazonaws.com/oc-tf-modules.zip//security/iampolicy/1.0.0"

  iam_policy_name      = "${var.envoy_instance_name}-cloudwatch-logs-policy"
  iam_policy_name_desc = "Policy for Envoy EC2 instances to push logs to CloudWatch"
  iam_policy_statements = [
    {
      Effect = "Allow"
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ]
      Resource = [
        local.cloudwatch_log_group_arn,
        local.cloudwatch_log_stream_arn
      ]
    }
  ]
  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "envoy_cloudwatch_policy" {
  role       = module.envoy_iam_role.name
  policy_arn = module.envoy_cloudwatch_policy.arn
}

resource "aws_iam_instance_profile" "envoy" {
  name = "${var.envoy_instance_name}-instance-profile"
  role = module.envoy_iam_role.name
  tags = var.tags
}

# ---------- Envoy Launch Template ----------

resource "aws_launch_template" "envoy" {
  name_prefix            = "${var.envoy_instance_name}-"
  image_id               = var.envoy_ami_id
  instance_type          = var.instance_type
  key_name               = var.ssh_key_name
  iam_instance_profile {
    name = aws_iam_instance_profile.envoy.name
  }

  network_interfaces {
    associate_public_ip_address = var.enable_public_ip
    security_groups             = [aws_security_group.envoy_sg.id]
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              set -e

              cat > /etc/envoy/envoy.yaml <<'EOC'
              ${local.envoy_config}
              EOC

              cat > /etc/envoy/envoy.env <<EOV
              ENVOY_LOG_GROUP=${var.cloudwatch_log_group_name}
              EOV

              chmod 644 /etc/envoy/envoy.env

              systemctl start cwagent-envoy.service
              
              systemctl restart envoy-docker.service
              EOF
  )

  # Fix for AVD-AWS-0028: Require IMDSv2
  metadata_options {
    http_tokens                 = "required"  # Enforce IMDSv2
    http_put_response_hop_limit = 1
    http_endpoint               = "enabled"
  }

  # Fix for AVD-AWS-0131: Encrypt root block device
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      encrypted   = true
      volume_size = var.root_volume_size
      volume_type = var.root_volume_type
      # Optional: specify KMS key if needed
      # kms_key_id = var.kms_key_id
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = merge(
      {
        Name = var.envoy_instance_name
      },
      var.tags
    )
  }

  update_default_version = true
}

# ---------- Envoy Auto Scaling Group ----------

resource "aws_autoscaling_group" "envoy" {
  name                = "${var.envoy_instance_name}-asg"
  vpc_zone_identifier = [var.envoy_subnet_id]
  min_size            = var.asg_min_size
  max_size            = var.asg_max_size
  desired_capacity    = var.asg_desired_capacity

  health_check_type         = "ELB"
  health_check_grace_period = var.health_check_grace_period

  target_group_arns = [
    aws_lb_target_group.envoy_tg.arn,
    aws_lb_target_group.envoy_health_tg.arn
  ]

  launch_template {
    id      = aws_launch_template.envoy.id
    version = "$Latest"
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = var.instance_refresh_min_healthy_percentage
    }
  }

  tag {
    key                 = "Name"
    value               = var.envoy_instance_name
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = var.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

# ---------- Data source to get ASG instances ----------

data "aws_instances" "envoy" {
  filter {
    name   = "tag:Name"
    values = [var.envoy_instance_name]
  }
  instance_state_names = ["running", "pending"]
  depends_on           = [aws_autoscaling_group.envoy]
}

# ---------- Security Group for NLB ----------

resource "aws_security_group" "nlb_sg" {
  name        = "${var.nlb_name}-nlb-sg"
  description = "Security group for Envoy NLB"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow traffic to listener port from VPC"
    from_port   = var.listener_port
    to_port     = var.listener_port
    protocol    = "tcp"
    cidr_blocks = var.vpc_cidr_blocks
  }

  ingress {
    description = "Allow traffic to healthcheck port from VPC"
    from_port   = var.healthcheck_port
    to_port     = var.healthcheck_port
    protocol    = "tcp"
    cidr_blocks = var.vpc_cidr_blocks
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.egress_cidr_blocks
  }

  tags = merge(
    {
      Name = "${var.nlb_name}-nlb-sg"
    },
    var.tags
  )
}

# ---------- Internal NLB + Target Group + Listener ----------

resource "aws_lb" "envoy_nlb" {
  name               = var.nlb_name
  internal           = true
  load_balancer_type = "network"
  subnets            = var.nlb_subnet_ids
  security_groups    = [aws_security_group.nlb_sg.id]

  # Disable enforcement of security group rules on PrivateLink traffic
  enforce_security_group_inbound_rules_on_private_link_traffic = "off"

  tags = merge(
    {
      Name = var.nlb_name
    },
    var.tags
  )
}

resource "aws_lb_target_group" "envoy_tg" {
  name     = substr("${var.nlb_name}-tg", 0, 32)
  port     = var.listener_port
  protocol = "TCP"
  vpc_id   = var.vpc_id

  health_check {
    protocol            = "HTTP"
    port                = var.healthcheck_port  # 8001
    path                = "/health"
    matcher             = "200"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 30
  }

  dynamic "stickiness" {
    for_each = var.enable_target_group_stickiness ? [1] : []
    content {
      type            = "source_ip"
      enabled         = true
      cookie_duration = var.stickiness_duration_seconds
    }
  }

  tags = merge(
    {
      Name = substr("${var.nlb_name}-tg", 0, 32)
    },
    var.tags
  )
}

resource "aws_lb_target_group" "envoy_health_tg" {
  name     = substr("${var.nlb_name}-hl", 0, 32)
  port     = var.healthcheck_port
  protocol = "TCP"
  vpc_id   = var.vpc_id

  health_check {
    protocol = "TCP"
    port     = "traffic-port"
  }

  tags = merge({ Name = "${var.nlb_name}-hl-tg" }, var.tags)
}

resource "aws_lb_listener" "envoy_nlb_listener" {
  load_balancer_arn = aws_lb.envoy_nlb.arn
  port              = var.listener_port
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.envoy_tg.arn
  }
}

resource "aws_lb_listener" "envoy_nlb_health_listener" {
  load_balancer_arn = aws_lb.envoy_nlb.arn
  port              = var.healthcheck_port
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.envoy_health_tg.arn
  }
}

# ---------- VPC Endpoint Service (for PrivateLink consumers) ----------

resource "aws_vpc_endpoint_service" "envoy_service" {
  acceptance_required = false

  network_load_balancer_arns = [
    aws_lb.envoy_nlb.arn
  ]

  tags = merge(
    {
      Name = var.endpoint_service_name != null ? var.endpoint_service_name : "${var.nlb_name}-ep-svc"
    },
    var.tags
  )
}
