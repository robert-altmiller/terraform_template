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
  for_each                 = jsondecode(var.databricks_submission_json)
  provider                 = databricks.workspace
  cluster_name             = each.value.resource_name
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