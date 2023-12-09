# required terraform providers
terraform {
  required_providers {
    aws = "~> 3.0"
    databricks = {
      source = "databricks/databricks"
    }
  }
  backend "s3" {}
  required_version = ">=0.13"
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
}

// Initialize provider in "MWS" mode to provision the new workspace.
// alias = "workspace" instructs Databricks to connect to https://accounts.cloud.databricks.com, to create
// a Databricks workspace that uses the E2 version of the Databricks on AWS platform.
// See https://registry.terraform.io/providers/databricks/databricks/latest/docs#authentication
provider "databricks" {
  alias = "workspace"
  host  = local.databricks_instance
  token = var.databricks_token
}