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

# Define a map with keys representing the module names and values representing the boolean flags
variable "module_conditions" {
  type = map(bool)
  default = {
    "cluster_module" = var.execute_cluster_module
    "uc_sc_module"   = var.execute_uc_sc_module
  }
}

# initialize cluster module with root level provider settings (inherited)
module "cluster_module" {
  source = "./clusters"
  for_each = var.module_conditions["cluster_module"] ? { enabled = true } : {}
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
  for_each = var.module_conditions["uc_sc_module"] ? { enabled = true } : {}
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