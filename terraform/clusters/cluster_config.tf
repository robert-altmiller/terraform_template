variable "cluster_config_json" {
    description = "JSON configuration for AWS"
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
    cluster_config = jsondecode(var.cluster_config_json)
  }