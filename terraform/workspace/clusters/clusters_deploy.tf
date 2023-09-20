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
  cluster_name             = lookup(each.value, "resource_name", null)
  node_type_id             = data.databricks_node_type.smallest.id
  spark_version            = data.databricks_spark_version.latest_lts.id
  autotermination_minutes  = lookup(each.value, "auto_termination_mins", null)
  num_workers              = lookup(each.value, "min_workers", null)
  
  autoscale {
    min_workers = lookup(each.value, "min_workers", null)
    max_workers = lookup(each.value, "max_workers", null)
  }

  custom_tags = {
    environment = var.environment
    owner       = var.github_actor
  }
}