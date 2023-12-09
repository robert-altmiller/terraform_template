resource "databricks_metastore_assignment" "this" {
#   metastore_id = databricks_metastore.this.id
  provider = databricks.mws
  metastore_id = local.vars.dbricks.conn.metastore_id
  workspace_id =  databricks_mws_workspaces.this.workspace_id
}