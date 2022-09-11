resource "aws_lb" "eks" {
  name               = local.alb.name
  internal           = false
  load_balancer_type = "application"
  subnets            = module.vpc.public_subnets
  security_groups = [
    aws_security_group.alb.id
  ]
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.eks.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate_validation.alb.certificate_arn

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
    target_group_arn = aws_lb_target_group.alb_argo.arn
  }
  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}

resource "aws_lb_target_group" "alb_argo" {
  name        = local.alb.target_group.argo
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = module.vpc.vpc_id
  health_check {
    port     = 80
    protocol = "HTTP"
    timeout  = 5
    interval = 10
    path     = "/healthz"
  }
}

resource "aws_acm_certificate" "alb" {
  domain_name       = local.alb.public_record
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "alb_cert" {
  for_each = {
    for dvo in aws_acm_certificate.alb.domain_validation_options : dvo.domain_name => {
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

resource "aws_acm_certificate_validation" "alb" {
  certificate_arn         = aws_acm_certificate.alb.arn
  validation_record_fqdns = [for record in aws_route53_record.alb_cert : record.fqdn]
}

resource "aws_route53_record" "alb" {
  zone_id = data.aws_route53_zone.public.id
  name    = local.alb.public_record
  type    = "A"

  alias {
    name                   = aws_lb.eks.dns_name
    zone_id                = aws_lb.eks.zone_id
    evaluate_target_health = true
  }
}
