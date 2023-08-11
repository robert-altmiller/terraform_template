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

// Initialize provider in "MWS" mode to provision the new workspace.
// alias = "mws" instructs Databricks to connect to https://accounts.cloud.databricks.com, to create
// a Databricks workspace that uses the E2 version of the Databricks on AWS platform.
// See https://registry.terraform.io/providers/databricks/databricks/latest/docs#authentication
provider "databricks" {
  alias    = "mws"
  host     = "https://accounts.cloud.databricks.com"
  account_id = local.databricks_account_id
  client_id = local.databricks_client_id
  client_secret = local.databricks_client_secret
  # username = local.databricks_admin_login
  # password = local.databricks_admin_password
}

provider "databricks" {
  alias = "workspace"
  host     = local.databricks_instance
  token = local.databricks_token
}

# initialize cluster module with root level provider settings (inherited)
# module "cluster_submodule" {
#   source = "./clusters"
#   github_actor = var.github_actor
#   environment = var.environment 
#   # databricks_account_id = local.databricks_account_id
#   # databricks_client_id = local.databricks_client_id
#   # databricks_client_secret = local.databricks_client_secret
#   # databricks_admin_login = local.databricks_admin_login
#   # databricks_admin_password = local.databricks_admin_password
#   databricks_token_dev = var.databricks_token_dev
# }