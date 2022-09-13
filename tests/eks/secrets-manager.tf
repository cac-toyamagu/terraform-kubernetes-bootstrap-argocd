# One can use secrets manager
# resource "aws_secretsmanager_secret" "sso" {
#   name = local.aws_sm_sso.name
# }

# data "aws_secretsmanager_secret_version" "sso" {
#   secret_id = aws_secretsmanager_secret.sso.id
# }

# resource "null_resource" "register_secret" {
#   count = local.aws_sm_sso.is_set ? 1 : 0
#   triggers = {
#     sso_secret_string = data.aws_secretsmanager_secret_version.sso.secret_string
#   }
#   provisioner "local-exec" {
#     environment = {
#       CLIENT_ID     = local.aws_sm_sso.values.client_id
#       CLIENT_SECRET = local.aws_sm_sso.values.client_secret
#       SECRET_ID     = aws_secretsmanager_secret.sso.arn
#     }
#     command     = "${path.cwd}/scripts/register_secret.sh"
#     interpreter = ["bash"]
#   }
#   depends_on = [
#     aws_secretsmanager_secret.sso
#   ]
# }
