# sc = storage credentials
variable "schema_config_json" {
    description = "JSON configuration for Databricks UC schema"
    type        = string
    default     = <<EOT
  {
    "catalog_name": "main",
    "schema_name": "dbo",
    "principal_name": "prod-contributors",
    "principal_privileges": "USE_SCHEMA"
  }
  EOT
  }
  
  locals {
    schema_config = jsondecode(var.schema_config_json)
  }