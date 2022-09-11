resource "aws_security_group" "alb" {
  name        = local.alb.name
  description = "SG for EKS ALB"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "From source ip"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.source_cidrs
  }

  egress {
    description = "Internet access"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
