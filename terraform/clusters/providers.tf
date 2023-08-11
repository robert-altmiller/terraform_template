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
  alias    = "mws"
  host     = "https://accounts.cloud.databricks.com"
  #account_id = "f6a3de67-0410-40f1-a5af-257cf3ee00d2" #var.databricks_account_id
  username = "altmiller.robert@outlook.com" #var.databricks_admin_login
  password = "61Klash17!" #var.databricks_admin_password
  # client_id = var.databricks_client_id
  # client_secret = var.databricks_client_secret
}