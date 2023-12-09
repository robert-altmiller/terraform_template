# get an existing account group name (admins)
data "databricks_group" "existing_group_admins_account" {
  provider = databricks.mws
  display_name = local.vars.dbricks.ws.admins_aad_group
}

# add account level aad admin group as a workspace admin (must wait 30 - 60 seconds)
resource "databricks_mws_permission_assignment" "add_existing_group_admins" {
  depends_on = [databricks_mws_workspaces.this, time_sleep.wait_2_minutes]
  provider     = databricks.mws
  workspace_id = databricks_mws_workspaces.this.workspace_id
  principal_id = data.databricks_group.existing_group_admins_account.id
  permissions  = ["ADMIN"]
}

data "databricks_group" "existing_group_admins_workspace" {
  depends_on = [databricks_mws_permission_assignment.add_existing_group_admins]
  provider = databricks.workspace
  display_name = local.vars.dbricks.ws.admins_aad_group
}

# add all entitlements to the account level aad admin group in the workspace
# this can only be done once the account level group is added to the workspace
resource "databricks_entitlements" "existing_group_admins_entitlements" {
  depends_on = [databricks_mws_permission_assignment.add_existing_group_admins, time_sleep.wait_2_minutes]
  provider                   = databricks.workspace
  group_id                   = data.databricks_group.existing_group_admins_workspace.id
  workspace_access           = true
  databricks_sql_access      = true
  allow_cluster_create       = true
  allow_instance_pool_create = true
}

resource "time_sleep" "wait_2_minutes" {
  # Wait for 2 minutes
  create_duration = "120s"
}