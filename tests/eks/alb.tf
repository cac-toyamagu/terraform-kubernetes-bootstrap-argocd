resource "aws_lb" "eks" {
  name               = local.alb.name
  internal           = false
  load_balancer_type = "application"
  subnets            = module.vpc.public_subnets
  security_groups = [
    aws_security_group.alb.id,
    module.eks.node_security_group_id # for health check to Node group
  ]
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.eks.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate_validation.argo.certificate_arn

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Not found."
      status_code  = "404"
    }
  }
}

resource "aws_lb_listener_rule" "argo" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 100
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.argo.arn
  }
  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}

# ALB TG. Port 30080 is fixed nginx-ingress-controller NodePort
resource "aws_lb_target_group" "argo" {
  name        = "${local.alb.target_group.argo}-${substr(uuid(), 0, 4)}"
  port        = 30080
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = module.vpc.vpc_id
  health_check {
    port     = 30080
    protocol = "HTTP"
    timeout  = 2
    interval = 5
    path     = "/nginx-health" # health check path for nginx ingress controller
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      name
    ]
  }
}

resource "aws_autoscaling_attachment" "argo" {
  autoscaling_group_name = module.eks.eks_managed_node_groups["one"].node_group_autoscaling_group_names[0]
  lb_target_group_arn    = aws_lb_target_group.argo.arn
}

# ALB Certificate settings
resource "aws_acm_certificate" "argo" {
  domain_name       = local.alb.public_record
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "argo_cert" {
  for_each = {
    for dvo in aws_acm_certificate.argo.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.public.zone_id
}

resource "aws_acm_certificate_validation" "argo" {
  certificate_arn         = aws_acm_certificate.argo.arn
  validation_record_fqdns = [for record in aws_route53_record.argo_cert : record.fqdn]
}

resource "aws_route53_record" "argo" {
  zone_id = data.aws_route53_zone.public.id
  name    = local.alb.public_record
  type    = "A"

  alias {
    name                   = aws_lb.eks.dns_name
    zone_id                = aws_lb.eks.zone_id
    evaluate_target_health = true
  }
}

