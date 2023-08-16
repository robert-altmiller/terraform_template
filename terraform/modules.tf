# initialize cluster module with root level provider settings (inherited)
module "cluster_module" {
  source = "./clusters"
  databricks_deploy_clusters = var.databricks_deploy_clusters
  github_actor = var.github_actor
  environment = var.environment 
  databricks_account_id = local.databricks_account_id
  databricks_instance = local.databricks_instance
  databricks_client_id = local.databricks_client_id
  databricks_client_secret = local.databricks_client_secret
  databricks_admin_login = local.databricks_admin_login
  databricks_admin_password = local.databricks_admin_password
  databricks_token = local.databricks_token
}

# initialize unity catalog storage credential (sc) with root level provider settings (inherited)
module "uc_sc_module" {
  source = "./unity_catalog/storage_creds"
  databricks_deploy_uc_storage_credential = var.databricks_deploy_uc_storage_credential
  github_actor = var.github_actor
  environment = var.environment 
  databricks_account_id = local.databricks_account_id
  databricks_instance = local.databricks_instance
  databricks_client_id = local.databricks_client_id
  databricks_client_secret = local.databricks_client_secret
  databricks_admin_login = local.databricks_admin_login
  databricks_admin_password = local.databricks_admin_password
  databricks_token = local.databricks_token
}

# initialize unity catalog schema with root level provider settings (inherited)
module "uc_schema_module" {
  source = "./unity_catalog/schemas"
  databricks_deploy_uc_storage_credential = var.databricks_deploy_schema
  github_actor = var.github_actor
  environment = var.environment 
  databricks_account_id = local.databricks_account_id
  databricks_instance = local.databricks_instance
  databricks_client_id = local.databricks_client_id
  databricks_client_secret = local.databricks_client_secret
  databricks_admin_login = local.databricks_admin_login
  databricks_admin_password = local.databricks_admin_password
  databricks_token = local.databricks_token
}