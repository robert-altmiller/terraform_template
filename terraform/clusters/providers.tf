# required terraform providers
terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
    }
  }
}

// Initialize provider in "MWS" mode to provision the new workspace.
// alias = "mws" instructs Databricks to connect to https://accounts.cloud.databricks.com, to create
// a Databricks workspace that uses the E2 version of the Databricks on AWS platform.
// See https://registry.terraform.io/providers/databricks/databricks/latest/docs#authentication
provider "databricks" {
  alias    = "workspace"
  host     = "https://dbc-b53dc9b9-da2a.cloud.databricks.com/" # "https://accounts.cloud.databricks.com"
  token = var.databricks_token_dev
  #account_id = var.databricks_account_id
  #client_id = var.databricks_client_id
  #client_secret = var.databricks_client_secret
  #username = var.databricks_admin_login
  #password = var.databricks_admin_password
}


# provider "databricks" {
#   alias         = "workspace"
#   host          = var.workspace_host
#   client_id     = var.client_id
#   client_secret = var.client_secret
# }