data "aws_secretsmanager_secret" "dbricks_admin_login_secret" {
    arn = "arn:aws:secretsmanager:us-west-2:490645555456:secret:databricks_admin_login-WZk5jV"
}
data "aws_secretsmanager_secret_version" "dbricks_admin_login_secret_version" {
    secret_id = data.aws_secretsmanager_secret.dbricks_admin_login_secret.id
}
output "secret_string_dbricks_admin_login" {
  value = jsondecode(nonsensitive(data.aws_secretsmanager_secret_version.dbricks_admin_login_secret_version.secret_string))
}


data "aws_secretsmanager_secret" "dbricks_admin_pwd_secret" {
    arn = "arn:aws:secretsmanager:us-west-2:490645555456:secret:databricks_admin_password-Eb8ZMU"
}
data "aws_secretsmanager_secret_version" "dbricks_admin_pwd_secret_version" {
    secret_id = data.aws_secretsmanager_secret.dbricks_admin_pwd_secret.id
}
output "secret_string_dbricks_admin_pwd" {
  value = jsondecode(nonsensitive(data.aws_secretsmanager_secret_version.dbricks_admin_pwd_secret_version.secret_string))
}


data "aws_secretsmanager_secret" "dbricks_instance_secret" {
    arn = "arn:aws:secretsmanager:us-west-2:490645555456:secret:databricks_instance-0aT1HT"
}
data "aws_secretsmanager_secret_version" "dbricks_instance_secret_version" {
    secret_id = data.aws_secretsmanager_secret.dbricks_instance_secret.id
}
output "secret_string_dbricks_instance" {
  value = jsondecode(nonsensitive(data.aws_secretsmanager_secret_version.dbricks_instance_secret_version.secret_string))
}


data "aws_secretsmanager_secret" "dbricks_token_secret" {
    arn = "arn:aws:secretsmanager:us-west-2:490645555456:secret:databricks_token-fy3b1z"
}
data "aws_secretsmanager_secret_version" "dbricks_token_secret_version" {
    secret_id = data.aws_secretsmanager_secret.dbricks_token_secret.id
}
output "secret_string_dbricks_token" {
  value = jsondecode(nonsensitive(data.aws_secretsmanager_secret_version.dbricks_token_secret_version.secret_string))
}