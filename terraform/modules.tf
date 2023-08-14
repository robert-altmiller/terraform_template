variable "execute_cluster_module" {
  description = "Set to true to execute the cluster module, false to skip."
  type        = bool
  default     = false
}


variable "execute_uc_sc_module" {
  description = "Set to true to execute the unity catalog  module, false to skip."
  type        = bool
  default     = false
}

# initialize cluster module with root level provider settings (inherited)
module "cluster_module" {
  source = "./clusters"
  count  = var.execute_cluster_module ? 1 : 0
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
  execute_uc_sc_module = var.execute_uc_sc_module
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