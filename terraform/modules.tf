# initialize cluster module with root level provider settings (inherited)
module "cluster_module" {
  source = "./workspace/clusters"
  providers = {
    databricks.workspace = databricks.workspace
  }
  environment = var.environment
  github_actor = var.github_actor
  databricks_instance = local.databricks_instance
  databricks_token = var.databricks_token
  databricks_submission_json = var.databricks_submission_json
}

# initialize cluster policies module with root level provider settings (inherited)
module "cluster_policies_module" {
  depends_on = [module.cluster_module]
  source = "./workspace/cluster_policies"
  providers = {
    databricks.workspace = databricks.workspace
  }
  github_actor = var.github_actor
  databricks_instance = local.databricks_instance
  databricks_token = var.databricks_token
  databricks_submission_json = var.databricks_submission_json
}

# initialize unity catalog storage credential (sc) with root level provider settings (inherited)
module "uc_sc_module" {
  source = "./unity_catalog/storage_creds"
  providers = {
    databricks.workspace = databricks.workspace
  }
  github_actor = var.github_actor
  databricks_client_id = local.databricks_client_id
  databricks_instance = local.databricks_instance
  databricks_token = var.databricks_token
  databricks_submission_json = var.databricks_submission_json
}

# initialize unity catalog external location with root level provider settings (inherited)
module "uc_el_module" {
  depends_on = [module.uc_sc_module]
  source = "./unity_catalog/external_locations"
  providers = {
    databricks.workspace = databricks.workspace
  }
  github_actor = var.github_actor
  databricks_client_id = local.databricks_client_id
  databricks_instance = local.databricks_instance
  databricks_token = var.databricks_token
  databricks_submission_json = var.databricks_submission_json
}

# initialize unity catalog catalog with root level provider settings (inherited)
module "uc_catalog_module" {
  depends_on = [module.uc_el_module]
  source = "./unity_catalog/catalogs"
  providers = {
    databricks.workspace = databricks.workspace
  }
  github_actor = var.github_actor
  databricks_client_id = local.databricks_client_id
  databricks_instance = local.databricks_instance
  databricks_token = var.databricks_token
  databricks_submission_json = var.databricks_submission_json
}

# initialize unity catalog schema with root level provider settings (inherited)
module "uc_schema_module" {
  depends_on = [module.uc_catalog_module, module.uc_el_module]
  source = "./unity_catalog/schemas"
  providers = {
    databricks.workspace = databricks.workspace
  }
  github_actor = var.github_actor
  databricks_client_id = local.databricks_client_id
  databricks_instance = local.databricks_instance
  databricks_token = var.databricks_token
  databricks_submission_json = var.databricks_submission_json
}

# initialize delta shares with root level provider settings (inherited)
module "delta_shares_module" {
  source = "./workspace/delta_shares"
  providers = {
    databricks.workspace = databricks.workspace
  }
  github_actor = var.github_actor
  databricks_client_id = local.databricks_client_id
  databricks_instance = local.databricks_instance
  databricks_token = var.databricks_token
  databricks_submission_json = var.databricks_submission_json
}