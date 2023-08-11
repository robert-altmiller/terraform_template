# Create the cluster with the "smallest" amount
# of resources allowed.
data "databricks_node_type" "smallest" {
  local_disk = true
}

# Use the latest Databricks Runtime
# Long Term Support (LTS) version.
# data "databricks_spark_version" "latest_lts" {
#   provider = databricks.mws
#   ml = true
# }

resource "databricks_cluster" "this" {
  provider                = databricks.workspace 
  cluster_name            = "${local.cluster_config.cluster_name}-${local.environment}"
  node_type_id            = data.databricks_node_type.smallest.id
  spark_version           = "12.2.x-scala2.12" #data.databricks_spark_version.latest_lts.id
  autotermination_minutes = 60#format("%d", local.cluster_config.auto_termination_mins)
  num_workers             = 1#format("%d", local.cluster_config.min_workers)
  
  autoscale {
    min_workers = 1#format("%d", local.cluster_config.min_workers)
    max_workers = 4#format("%d", local.cluster_config.max_workers)
  }
  
  custom_tags = {
    environment = local.environment
    owner       = local.github_actor
  }
}

# output cluster url to check if cluster was created successfully
output "cluster_url" {
 value = databricks_cluster.this.url
}