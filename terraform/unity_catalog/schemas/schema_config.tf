# sc = storage credentials
variable "schema_config_json" {
    description = "JSON configuration for Databricks UC schema"
    type        = string
    default     = <<EOT
  {
    "schema_name": "main2"
  }
  EOT
  }
  
  locals {
    schema_config = jsondecode(var.schema_config_json)
  }