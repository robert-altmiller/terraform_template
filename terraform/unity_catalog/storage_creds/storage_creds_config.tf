# sc = storage credentials
variable "sc_config_json" {
    description = "JSON configuration for Databricks UC storage credentials"
    type        = string
    default     = <<EOT
  {
    "sc_name": "my-storage-creds7",
    "sc_role_arn": "arn:aws:iam::969341422355:role/s3-dbricks-prod-bucket-role",
    "principal_name": "prod-contributors",
    "principal_privileges": ["ALL_PRIVILEGES"]
  }
  EOT
  }
  
  locals {
    sc_config = jsondecode(var.sc_config_json)
  }