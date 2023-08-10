locals {
  source_dir = "${var.source_dir}"
}

locals {
  aws_region = "${var.aws_region}"
}

locals {
  aws_access_key_id = "${var.aws_access_key_id}"
}


locals {
  aws_access_key_secret = "${var.aws_access_key_secret}"
}

output "source_dir_output" {
  value = jsonencode(local.source_dir)
  description = "value for source_dir"
}

output "aws_region_output" {
  value = jsonencode(local.aws_region)
  description = "value for aws_region"
}

output "aws_access_key_id_output" {
  value = jsonencode(local.aws_access_key_id)
  description = "value for aws_access_key_id"
}

output "aws_access_key_secret_output" {
  value = jsonencode(local.aws_access_key_secret)
  description = "value for aws_access_key_secret"
}

output "databricks_admin_login_output" {
  value = jsonencode(local.databricks_admin_login)
  description = "value for databricks_admin_login"
}

output "databricks_admin_password_output" {
  value = jsonencode(local.databricks_admin_password)
  description = "value for databricks_admin_password"
}