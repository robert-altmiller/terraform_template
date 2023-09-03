# # cluster policy config json
# variable "cluster_policy_config_json" {
#   description = "JSON configuration for Databricks cluster policies"
#   type        = string
#   default     = <<-EOT
#   {
#     "cluster_policy_name": "personal-compute-policy",
#     "cluster_profile": "singleNode",
#     "cluster_type": "all-purpose",
#     "runtime_engine": "STANDARD",
#     "node_type_id": ["i3.xlarge", "i3.2xlarge"],
#     "spark_version": "auto:latest-ml",
#     "num_workers": 0,
#     "min_workers": 1,
#     "max_workers": 2,
#     "auto_termination_mins": 60,
#     "cluster_policy_principal_name": "contributors",
#     "cluster_policy_principal_privileges": "CAN_USE"
#   }
#     EOT
# }

# cluster policy config
locals {
    cluster_policy_config = jsondecode(var.databricks_submission_json)
}

locals {
  cluster_policy_config_settings = { 
    for key, config in local.cluster_policy_config.cluster_policies : key => { 
      node_type_id = {
        type         = "allowlist",
        values       = try(config.node_typeid, null)
        defaultValue = ["i3.xlarge"]
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