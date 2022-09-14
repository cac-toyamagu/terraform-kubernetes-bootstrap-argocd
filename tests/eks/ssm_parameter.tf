# If sso_credentials are set, exec script which register sso credentials to SSM parameter store.
resource "null_resource" "register_secret" {
  count = local.sso_credentials.is_set ? 1 : 0
  triggers = {
    run_always = "${timestamp()}"
  }
  provisioner "local-exec" {
    environment = {
      CLIENT_ID          = local.sso_credentials.values.client_id
      CLIENT_SECRET      = local.sso_credentials.values.client_secret
      CLIENT_ID_NAME     = aws_ssm_parameter.client_id.name
      CLIENT_SECRET_NAME = aws_ssm_parameter.client_secret.name
    }
    command     = "${path.cwd}/scripts/register_aws_ssm_pms.sh"
    interpreter = ["bash"]
  }
}

data "aws_ssm_parameter" "client_id" {
  name = aws_ssm_parameter.client_id.name
}

data "aws_ssm_parameter" "client_secret" {
  name = aws_ssm_parameter.client_secret.name
}
