# required terraform providers
terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
    }
  }
}

// Initialize provider in "MWS" mode to provision the new workspace.
// alias = "workspace" instructs Databricks to connect to https://accounts.cloud.databricks.com, to create
// a Databricks workspace that uses the E2 version of the Databricks on AWS platform.
// See https://registry.terraform.io/providers/databricks/databricks/latest/docs#authentication
provider "databricks" {
  alias    = "account"
  host     = "https://accounts.cloud.databricks.com"
  account_id = var.databricks_account_id
  client_id = var.databricks_client_id
  client_secret = var.databricks_client_secret
}


provider "databricks" {
  alias = "workspace"
  host  = var.databricks_instance
  token = var.databricks_token
}