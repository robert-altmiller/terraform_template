# create the cluster with the "smallest" amount of resources allowed
data "databricks_node_type" "smallest" {
  local_disk = true
}

# use the latest Databricks Runtime
data "databricks_spark_version" "latest_lts" {
  provider = databricks.workspace
  ml = true
  latest = true
}

# create databrickls cluster
resource "databricks_cluster" "create_cluster" {
  for_each                 = local.cluster_config.clusters
  provider                 = databricks.workspace
  cluster_name             = each.value.cluster_name
  node_type_id             = data.databricks_node_type.smallest.id
  spark_version            = data.databricks_spark_version.latest_lts.id
  autotermination_minutes  = each.value.auto_termination_mins
  num_workers              = each.value.min_workers
  
  autoscale {
    min_workers = each.value.min_workers
    max_workers = each.value.max_workers
  }

  custom_tags = {
    environment = var.environment
    owner       = var.github_actor
  }
}

# # create databrickls cluster
# resource "databricks_cluster" "create_cluster" {
#   count                   = var.databricks_deploy_clusters == "true" ? 1 : 0 # used as a conditional
#   provider                = databricks.workspace
#   cluster_name            = "${local.cluster_config.cluster_name}-${var.environment}"
#   node_type_id            = data.databricks_node_type.smallest.id
#   spark_version           =  data.databricks_spark_version.latest_lts.id
#   autotermination_minutes = local.cluster_config.auto_termination_mins
#   num_workers             = local.cluster_config.min_workers
  
#   autoscale {
#     min_workers = local.cluster_config.min_workers
#     max_workers = local.cluster_config.max_workers
#   }
  
#   custom_tags = {
#     environment = var.environment
#     owner       = var.github_actor
#   }
# }