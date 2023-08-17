variable "cluster_policy_config_json" {
    description = "JSON configuration for Databricks cluster policies"
    type        = string
    default     = <<EOT
  {
    "cluster_policy_name": "personal-compute-policy",
    "cluster_profile: "singleNode"
    "cluster_type": "all-purpose",
    "runtime_engine": "STANDARD"
    "node_type_id": ["i3.xlarge", "i3.2xlarge"],
    "spark_version": "auto:latest-ml",
    "min_workers": 1,
    "max_workers": 2,
    "auto_termination_mins": 60,
    "runtime_engine": "standard"

  }
  EOT
  }
  
  locals {
    cluster_policy_config = jsondecode(var.cluster_policy_config_json)
  }

locals {
  cluster_policy_details = {
    node_type_id = {
      type         = "allowlist"
      values       = local.cluster_policy_config.node_type_id
      defaultValue = "i3.xlarge"
    },
    spark_version = {
      type         = "unlimited"
      defaultValue = local.cluster_policy_config.spark_version
    },
    runtime_engine = {
      type: "fixed",
      value: local.cluster_policy_config.runtime_engine,
      hidden: true
    },
    num_workers = {
      type   = "fixed"
      value  = local.cluster_policy_config.min_workers
      hidden = true
    },
    driver_instance_pool_id = {
      type   = "forbidden"
      hidden = true
    },
    cluster_type = {
      type  = "fixed"
      value = local.cluster_policy_config.cluster_type
    },
    instance_pool_id = {
      type   = "forbidden"
      hidden = true
    },
    spark_conf_spark_databricks_cluster_profile = {
      type: "fixed",
      value: local.cluster_policy_config.cluster_profile,
      hidden: true
    },
    autotermination_minutes = {
      type       = "unlimited"
      defaultValue = local.cluster_policy_config.auto_termination_mins
      isOptional = true
    }
  }
}