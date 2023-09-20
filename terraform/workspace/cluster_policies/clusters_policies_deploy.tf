# deploy cluster policy
resource "databricks_cluster_policy" "policy" {
  for_each   = local.cluster_policy_config.cluster_policies
  provider   = databricks.workspace
  name       = each.value.resource_name
  definition = jsonencode(local.cluster_policy_config_settings[each.key])
}

# add grants to the cluster policy
resource "databricks_permissions" "policy_grants" {
  for_each          = local.cluster_policy_config.cluster_policies
  provider          = databricks.workspace
  cluster_policy_id = databricks_cluster_policy.policy[each.key].id
  access_control {
    group_name       = "${var.environment}-${each.value.cluster_policy_principal_name}"
    permission_level = each.value.cluster_policy_principal_privileges
  }
  # access_control {
  #   user_name  = "user@example.com"
  #   permission_level = "CAN_USE"
  # }
}