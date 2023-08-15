# required terraform providers
terraform {
  required_providers {
    aws = "~> 3.0"
    databricks = {
      source = "databricks/databricks"
    }
  }
  required_version = ">=0.12.8"
  backend "s3" {
    bucket = "dbricks-dev-bucket"
    key = "terraform.tfstate"
    region = local.aws_region
    # access_key = local.aws_access_key_id
    # secret_key = local.aws_secret_access_key
  }
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

# // initialize provider in normal mode
# provider "databricks" {
#   alias = "workspace"
#   host = local.databricks_instance
#   account_id = local.databricks_account_id
#   client_id = local.databricks_client_id
#   client_secret = local.databricks_client_secret
# }

# // create personal access token (PAT) to provision entities within Databricks workspace
# resource "databricks_token" "pat" {
#   provider = databricks.workspace
#   comment  = "terraform provisioning databricks workspace token"
#   // 60 minute token
#   lifetime_seconds = 3600
# }