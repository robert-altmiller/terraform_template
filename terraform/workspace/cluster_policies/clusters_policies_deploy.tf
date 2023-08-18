resource "databricks_cluster_policy" "policy" {
  provider = databricks.workspace
  count = var.databricks_deploy_cluster_policies == "true" ? 1 : 0 # used as a conditional
  name       = "${local.cluster_policy_config.cluster_policy_name}-${var.environment}"
  definition = jsonencode(local.cluster_policy_details)
}

resource "databricks_permissions" "policy_grants" {
  provider = databricks.workspace
  cluster_policy_id = databricks_cluster_policy.policy.id
  access_control {
    group_name  = local.cluster_policy_config.principal_name
    permission_level = local.cluster_policy_config.principal_privileges
  }
  # access_control {
  #   user_name  = "user@example.com"
  #   permission_level = "CAN_USE"
  # }
}