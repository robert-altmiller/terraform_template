# cluster policy config
locals {
    cluster_policy_config = jsonencode(var.databricks_submission_json)
}

locals {
  cluster_policy_config_settings = { 
    for key, config in local.cluster_policy_config.cluster_policies : key => { 
      node_type_id = {
        type         = "allowlist",
        values       = try(config.nodetype_id, null)
        defaultValue = "i3.xlarge"
      },
      spark_version = {
        type         = "unlimited",
        defaultValue = try(config.spark_version, null)
      },
      runtime_engine = {
        type: "fixed",
        value: try(config.runtime_engine, null)
        hidden: true
      },
      num_workers = {
        type   = "fixed",
        value  = try(tonumber(config.num_workers), null)
        hidden = true
      },
      driver_instance_pool_id = {
        type   = "forbidden",
        hidden = true
      },
      cluster_type = {
        type  = "fixed",
        value = try(config.cluster_type, null)
      },
      instance_pool_id = {
        type   = "forbidden",
        hidden = true
      },
      "spark_conf.spark.databricks.cluster.profile" = {
        type: "fixed",
        value: try(config.cluster_profile, null),
        hidden: true
      },
      autotermination_minutes = {
        type       = "unlimited",
        defaultValue = try(tonumber(config.auto_termination_mins), null),
        isOptional = true
      }
    }
  }
}

# # cluster policy details
# locals {
#   cluster_policy_details = {
#     node_type_id = {
#       type         = "allowlist",
#       values       = local.cluster_policy_config.node_type_id,
#       defaultValue = "i3.xlarge"
#     },
#     spark_version = {
#       type         = "unlimited",
#       defaultValue = local.cluster_policy_config.spark_version
#     },
#     runtime_engine = {
#       type: "fixed",
#       value: local.cluster_policy_config.runtime_engine,
#       hidden: true
#     },
#     num_workers = {
#       type   = "fixed",
#       value  = local.cluster_policy_config.num_workers,
#       hidden = true
#     },
#     driver_instance_pool_id = {
#       type   = "forbidden",
#       hidden = true
#     },
#     cluster_type = {
#       type  = "fixed",
#       value = local.cluster_policy_config.cluster_type
#     },
#     instance_pool_id = {
#       type   = "forbidden",
#       hidden = true
#     },
#     "spark_conf.spark.databricks.cluster.profile" = {
#       type: "fixed",
#       value: local.cluster_policy_config.cluster_profile,
#       hidden: true
#     },
#     autotermination_minutes = {
#       type       = "unlimited",
#       defaultValue = local.cluster_policy_config.auto_termination_mins,
#       isOptional = true
#     }
#   }
# }