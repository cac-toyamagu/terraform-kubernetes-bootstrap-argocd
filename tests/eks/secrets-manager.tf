# One can use secrets manager
# resource "aws_secretsmanager_secret" "sso" {
#   name = local.aws_sm_sso.name
# }

# data "aws_secretsmanager_secret_version" "sso" {
#   secret_id = aws_secretsmanager_secret.sso.id
# }


