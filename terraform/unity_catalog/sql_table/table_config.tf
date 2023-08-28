# table config json
variable "table_config_json" {
    description = "JSON configuration for Databricks UC storage credentials"
    type        = string
    default     = <<EOT
  {
    "storage_credentials": {
      "sc1": {
        "sc_name": "my-storage-creds7",
        "sc_role_arn": "arn:aws:iam::969341422355:role/s3-dbricks-prod-bucket-role",
        "sc_principal_name": "contributors",
        "sc_principal_privileges": ["ALL_PRIVILEGES"]
        "create_or_delete": "create"
      },
      "sc2": {
        "sc_name": "my-storage-creds8",
        "sc_role_arn": "arn:aws:iam::969341422355:role/s3-dbricks-prod-bucket-role",
        "sc_principal_name": "contributors",
        "sc_principal_privileges": ["ALL_PRIVILEGES"]
        "create_or_delete": "create"
      }
    }
  }
  EOT
  }
  
  # table config
  locals {
    table_config = jsondecode(var.table_config_json)
  }