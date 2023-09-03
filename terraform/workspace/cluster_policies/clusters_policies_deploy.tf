# # deploy cluster policy
# resource "databricks_cluster_policy" "policy" {
#   provider = databricks.workspace
#   name       = "${local.cluster_policy_config.cluster_policy_name}-${var.environment}"
#   definition = jsonencode(local.cluster_policy_details)
# }

# # add grants to the cluster policy
# resource "databricks_permissions" "policy_grants" {
#   count = var.databricks_deploy_cluster_policies == "true" ? 1 : 0 # used as a conditional because of 'databricks_cluster_policy.policy.id'
#   provider = databricks.workspace
#   cluster_policy_id = databricks_cluster_policy.policy.id
#   access_control {
#     group_name  = "${var.environment}-${local.cluster_policy_config.cluster_policy_principal_name}"
#     permission_level = local.cluster_policy_config.cluster_policy_principal_privileges
#   }
#   # access_control {
#   #   user_name  = "user@example.com"
#   #   permission_level = "CAN_USE"
#   # }
# }

# # deploy cluster policy
# resource "databricks_cluster_policy" "policy" {
#   for_each   = local.cluster_policy_config.cluster_policies
#   provider   = databricks.workspace
#   name       = each.value.cluster_policy_name
#   definition = jsonencode(local.cluster_policy_config_settings[each.key]) 
# }

# # add grants to the cluster policy
# resource "databricks_permissions" "policy_grants" {
#   for_each          = local.cluster_policy_config.cluster_policies
#   provider          = databricks.workspace
#   cluster_policy_id = databricks_cluster_policy.policy[each.key].id
#   access_control {
#     group_name       = "${var.environment}-${each.value.cluster_policy_principal_name}"
#     permission_level = each.value.cluster_policy_principal_privileges
#   }
#   # access_control {
#   #   user_name  = "user@example.com"
#   #   permission_level = "CAN_USE"
#   # }
# }

# deploy cluster policy
resource "databricks_cluster_policy" "policy" {
  for_each   = local.cluster_policy_config.cluster_policies
  provider   = databricks.workspace
  name       = each.value.cluster_policy_name
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