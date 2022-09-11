data "aws_route53_zone" "public" {
  name         = var.public_root_domain
  private_zone = false
}
