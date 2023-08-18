# cluster config json
variable "cluster_config_json" {
    description = "JSON configuration for Databricks clusters"
    type        = string
    default     = <<EOT
  {
    "cluster_name": "my-cluster",
    "auto_termination_mins": 60,
    "min_workers": 1,
    "max_workers": 2
  }
  EOT
  }

# cluster config  
locals {
    cluster_config = jsondecode(var.cluster_config_json)
  }