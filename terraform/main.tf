# source directory
locals {
  source_dir = "${var.source_dir}"
}

# aws region
locals {
  aws_region = "${var.aws_region}"
}

# aws access key id
locals {
  aws_access_key_id = "${var.aws_access_key_id}"
}

# aws access key secret
locals {
  aws_access_key_secret = "${var.aws_access_key_secret}"
}

# dbricks instance url
locals {
  databricks_instance = "${var.databricks_instance}"
}

# dbricks admin login
locals {
  databricks_admin_login = "${var.databricks_admin_login}"
}

# dbricks admin password
locals {
  databricks_admin_password = "${var.databricks_admin_password}"
}

# client id
locals {
  databricks_client_id = lookup(var.databricks_client_ids, var.environment)
}

# client secret
locals {
  databricks_client_secret = lookup(var.databricks_client_secrets, var.environment)
}



output "source_dir_output" {
  value = jsonencode(local.source_dir)
  description = "value for source_dir"
  sensitive = true
}

output "aws_region_output" {
  value = jsonencode(local.aws_region)
  description = "value for aws_region"
  sensitive = true
}

output "aws_access_key_id_output" {
  value = jsonencode(local.aws_access_key_id)
  description = "value for aws_access_key_id"
  sensitive = true
}

output "aws_access_key_secret_output" {
  value = jsonencode(local.aws_access_key_secret)
  description = "value for aws_access_key_secret"
  sensitive = true
}

output "databricks_instance_output" {
  value = jsonencode(local.databricks_instance)
  description = "value for databricks_instance"
  sensitive = true
}

output "databricks_admin_login_output" {
  value = jsonencode(local.databricks_admin_login)
  description = "value for databricks_admin_login"
  sensitive = true
}

output "databricks_admin_password_output" {
  value = jsonencode(local.databricks_admin_password)
  description = "value for databricks_admin_password"
  sensitive = true
}

output "databricks_client_id_output" {
  value = jsonencode(local.databricks_client_id)
  description = "value for databricks_admin_password"
  sensitive = true
}

output "databricks_client_secret_output" {
  value = jsonencode(local.databricks_client_secret)
  description = "value for databricks_admin_password"
  sensitive = true
}