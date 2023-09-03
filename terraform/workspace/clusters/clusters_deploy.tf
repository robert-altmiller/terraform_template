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
  for_each                 = try(local.cluster_config.clusters, {})
  provider                 = databricks.workspace
  cluster_name             = try(each.value.cluster_name, "n/a")
  node_type_id             = data.databricks_node_type.smallest.id
  spark_version            = data.databricks_spark_version.latest_lts.id
  autotermination_minutes  = try(each.value.auto_termination_mins, "n/a")
  num_workers              = try(each.value.min_workers, "n/a")
  
  autoscale {
    min_workers = try(each.value.min_workers, "n/a")
    max_workers = try(each.value.max_workers, "n/a")
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