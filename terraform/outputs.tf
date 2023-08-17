output "github_actor_output" {
  value = local.github_actor
  description = "value for github_actor"
}

output "environment_output" {
  value = local.environment
  description = "value for source_dir"
}

output "source_dir_output" {
  value = local.source_dir
  description = "value for source_dir"
}

output "aws_region_output" {
  value = local.aws_region
  description = "value for aws_region"
}

output "aws_access_key_id_output" {
  value = local.aws_access_key_id
  description = "value for aws_access_key_id"
}

output "aws_access_key_secret_output" {
  value = local.aws_access_key_secret
  description = "value for aws_access_key_secret"
}

output "databricks_account_id_output" {
  value = local.databricks_account_id
  description = "value for databricks_account_id"
}

output "databricks_instance_output" {
  value = local.databricks_instance
  description = "value for databricks_instance"
}

output "databricks_admin_login_output" {
  value = local.databricks_admin_login
  description = "value for databricks_admin_login"
}

output "databricks_admin_password_output" {
  value = local.databricks_admin_password
  description = "value for databricks_admin_password"
}

output "databricks_client_id_output" {
  value = local.databricks_client_id
  description = "value for databricks_admin_password"
}

output "databricks_client_secret_output" {
  value = local.databricks_client_secret
  description = "value for databricks_admin_password"
}

output "databricks_token_output" {
  value = local.databricks_token
  description = "value for databricks_token"
}

output "databricks_deploy_clusters_output" {
  value = local.databricks_deploy_clusters
  description = "value for databricks_deploy_cluster"
}

output "databricks_deploy_cluster_policies_output" {
  value = local.databricks_deploy_cluster_policies
  description = "value for databricks_deploy_cluster_policies"
}


output "databricks_deploy_uc_storage_credential_output" {
  value = local.databricks_deploy_uc_storage_credential
  description = "value for databricks_deploy_uc_storage_credential"
}

output "databricks_deploy_uc_schema_output" {
  value = local.databricks_deploy_uc_schema
  description = "value for databricks_deploy_uc_schema"
}