# create the cluster with the "smallest" amount of resources allowed
data "databricks_node_type" "smallest" {
  local_disk = true
}

# use the latest Databricks Runtime
data "databricks_spark_version" "latest_lts" {
  provider = databricks.workspace
  ml       = true
  latest   = true
}

# create databricks cluster
resource "databricks_cluster" "create_cluster" {
  for_each                 = jsondecode(var.databricks_submission_json)["clusters"]
  provider                 = databricks.workspace
  
  cluster_name             = try(each.value["resource_name"], "")
  node_type_id             = data.databricks_node_type.smallest.id
  spark_version            = data.databricks_spark_version.latest_lts.id
  autotermination_minutes  = try(tonumber(each.value["auto_termination_mins"]), "30")
  num_workers              = try(tonumber(each.value["min_workers"]), "1")
  
  autoscale {
    min_workers = try(tonumber(each.value["min_workers"]), "1")
    max_workers = try(tonumber(each.value["max_workers"]), "2")
  }

  custom_tags = {
    environment = var.environment
    owner       = var.github_actor
  }
}
