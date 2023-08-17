resource "databricks_cluster_policy" "policy" {
  
  count = var.databricks_deploy_cluster_policies == "true" ? 1 : 0 # used as a conditional
  name       = local.cluster_policy_config.cluster_policy_name
  definition = local.cluster_policy_details
}