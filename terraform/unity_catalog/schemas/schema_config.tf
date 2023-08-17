# sc = storage credentials
variable "schema_config_json" {
    description = "JSON configuration for Databricks UC schema"
    type        = string
    default     = <<EOT
  {
    "catalog_name": "main",
    "catalog_principal_privileges": "USE_SCHEMA"
    "schema_name": "dbo",
    "schema_principal_name": "prod-contributors",
    "schema_principal_privileges": "ALL_PRIVILEGES"
  }
  EOT
  }
  
  locals {
    schema_config = jsondecode(var.schema_config_json)
  }