locals {
  # github actor
  github_actor = var.github_actor
  # deploy environment 
  environment = var.environment
  # source directory
  source_dir = var.source_dir
  # aws region
  aws_region = var.aws_region
  # aws access key id
  aws_access_key_id = var.aws_access_key_id
  # aws access key secret
  aws_access_key_secret = var.aws_access_key_secret
  # dbricks account id
  databricks_account_id = var.databricks_account_id
  # dbricks instance url
  databricks_instance = lookup(var.databricks_instances, var.environment)
  # dbricks admin login
  databricks_admin_login = var.databricks_admin_login
  # dbricks admin password
  databricks_admin_password = var.databricks_admin_password
  # client id
  databricks_client_id = lookup(var.databricks_client_ids, var.environment)
  # client secret
  databricks_client_secret = lookup(var.databricks_client_secrets, var.environment)
  # databricks token
  databricks_token = lookup(var.databricks_tokens, var.environment)
  # deploy clusters
  databricks_deploy_clusters = var.databricks_deploy_clusters
  # deploy uc storage credential
  databricks_deploy_uc_storage_credential = var.databricks_deploy_uc_storage_credential
}