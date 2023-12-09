# Terraform required providers
terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.15.0"
    }
  }
}

# Initialize provider in "MWS" mode to provision new workspace
provider "databricks" {
  alias         = "mws"
  host          = local.vars.dbricks.conn.account_url
  account_id    = local.vars.dbricks.conn.account_id
  client_id     = local.vars.dbricks.conn.client_id
  client_secret = local.vars.dbricks.conn.client_secret
}

# initialize provider in "WORKSPACE" mode to provision new workspace
provider "databricks" {
  alias         = "workspace"
  host          = databricks_mws_workspaces.this.workspace_url
  token         = databricks_mws_workspaces.this.token[0].token_value
}

# Configure the AWS Provider
provider "aws" {
  region     = local.vars.aws.conn.region
  access_key = local.vars.aws.conn.access_key
  secret_key = local.vars.aws.conn.access_key_secret
}

# Configure the TIME provider
provider "time" {}