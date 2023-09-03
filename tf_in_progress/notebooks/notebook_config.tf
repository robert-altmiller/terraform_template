# notebook config json
variable "notebook_config_json" {
    description = "JSON configuration for Databricks notebooks"
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

# notebook config  
locals {
    notebook_config = jsondecode(var.notebook_config_json)
  }