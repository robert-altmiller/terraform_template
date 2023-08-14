# required terraform providers
terraform {
  required_providers {
    aws = "~> 3.0"
    databricks = {
      source = "databricks/databricks"
    }
  }
  required_version = ">=0.12.8"
}

# configure the aws provider
provider "aws" {
  region     = local.aws_region
  access_key = local.aws_access_key_id
  secret_key =  local.aws_secret_access_key
}

// Initialize provider in "account" mode to provision the new workspace.
// alias = "account" instructs Databricks to connect to https://accounts.cloud.databricks.com, to create
// a Databricks workspace that uses the E2 version of the Databricks on AWS platform.
// See https://registry.terraform.io/providers/databricks/databricks/latest/docs#authentication
provider "databricks" {
  alias    = "account"
  host     = "https://accounts.cloud.databricks.com"
  account_id = local.databricks_account_id
  client_id = local.databricks_client_id
  client_secret = local.databricks_client_secret
  # username = local.databricks_admin_login
  # password = local.databricks_admin_password
}

// initialize provider in normal mode
provider "databricks" {
  alias = "workspace"
  host = local.databricks_instance
}

// create PAT token to provision entities within workspace
resource "databricks_token" "pat" {
  provider = databricks.workspace
  comment  = "Terraform Provisioning"
  // 60 minute token
  lifetime_seconds = 3600
}

// output token for other modules
output "databricks_token" {
  value     = databricks_token.pat.token_value
  sensitive = true
}

variable "execute_cluster_module" {
  description = "Set to true to execute the cluster module, false to skip."
  type        = bool
  default     = false  # Set this to true or false based on your conditions
}

variable "execute_uc_sc_module" {
  description = "Set to true to execute the unity catalog  module, false to skip."
  type        = bool
  default     = false  # Set this to true or false based on your conditions
}


locals {
  execute_cluster_module = var.execute_cluster_module ? true : false
  execute_uc_sc_module = var.execute_uc_sc_module ? true : false
}

# initialize cluster module with root level provider settings (inherited)
module "cluster_module" {
  source = "./clusters"
  count  = local.execute_cluster_module ? 1 : 0  # This controls whether the module is executed
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
  count  = local.execute_uc_sc_module ? 1 : 0  # This controls whether the module is executed
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