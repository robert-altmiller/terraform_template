variable "uc_config_json" {
    description = "JSON configuration for Databricks unity catalog"
    type        = string
    default     = <<EOT
  {
    "cluster_name": "my-cluster",
    "auto_termination_mins": "60",
    "min_workers": "1",
    "max_workers": "4"
  }
  EOT
  }
  
  locals {
    uc_config = jsondecode(var.uc_config_json)
  }