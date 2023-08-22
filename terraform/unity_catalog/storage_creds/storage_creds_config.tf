# storage credential config json (sc = storage credentials)
variable "sc_config_json" {
    description = "JSON configuration for Databricks UC storage credentials"
    type        = string
    default     = <<EOT
  {
    "storage_credentials": {
      "sc2": {
        "sc_name": "my-storage-creds8",
        "sc_role_arn": "arn:aws:iam::969341422355:role/s3-dbricks-prod-bucket-role",
        "sc_principal_name": "contributors",
        "sc_principal_privileges": ["ALL_PRIVILEGES"]
      }
    }
  }
  EOT
  }
  
  # storage credential config
  locals {
    sc_config = jsondecode(var.sc_config_json)
  }