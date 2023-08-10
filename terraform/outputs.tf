output "github_actor_output" {
  value = jsonencode(local.github_actor)
  description = "value for github_actor"
  sensitive = true
}

output "environment_output" {
  value = jsonencode(local.environment)
  description = "value for source_dir"
  sensitive = true
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

output "databricks_deploy_clusters_output" {
  value = jsonencode(local.databricks_deploy_clusters)
  description = "value for databricks_deploy_cluster"
  sensitive = true
}

