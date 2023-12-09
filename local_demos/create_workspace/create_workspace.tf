# create a databricks workspace
resource "databricks_mws_workspaces" "this" {
  provider       = databricks.mws
  account_id     = local.vars.dbricks.conn.account_id
  aws_region     = local.vars.aws.conn.region
  workspace_name = local.vars.dbricks.ws.name
  deployment_name = local.vars.dbricks.ws.deployment_name

  credentials_id           = databricks_mws_credentials.this.credentials_id
  storage_configuration_id = databricks_mws_storage_configurations.this.storage_configuration_id
  network_id               = databricks_mws_networks.this.network_id

  token {
    comment = "Managed By Terraform (TF)"
  }
}