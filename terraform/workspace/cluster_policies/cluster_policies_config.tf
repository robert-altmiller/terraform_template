# cluster policy config settings
locals {
  decoded_cluster_policy_config = jsondecode(var.databricks_submission_json)
  cluster_policy_config_settings = { 
    for key, config in local.decoded_cluster_policy_config["cluster_policies"] : key => { 
      node_type_id = {
        type         = "allowlist",
        values       = try(config.nodetype_id, "")
        defaultValue = "i3.xlarge"
      },
      spark_version = {
        type         = "unlimited",
        defaultValue = try(config.spark_version, "")
      },
      runtime_engine = {
        type: "fixed",
        value: try(config.runtime_engine, "")
        hidden: true
      },
      num_workers = {
        type   = "fixed",
        value  = try(tonumber(config.num_workers), "")
        hidden = true
      },
      driver_instance_pool_id = {
        type   = "forbidden",
        hidden = true
      },
      cluster_type = {
        type  = "fixed",
        value = try(config.cluster_type, "")
      },
      instance_pool_id = {
        type   = "forbidden",
        hidden = true
      },
      "spark_conf.spark.databricks.cluster.profile" = {
        type = "fixed",
        value = try(config.cluster_profile, ""),
        hidden = true
      },
      autotermination_minutes = {
        type       = "unlimited",
        defaultValue = try(tonumber(config.auto_termination_mins), "30"),
        isOptional = true
      }
    }
  }
}