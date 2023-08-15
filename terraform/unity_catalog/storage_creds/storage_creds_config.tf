# sc = storage credentials
variable "sc_config_json" {
    description = "JSON configuration for Databricks UC storage credentials"
    type        = string
    default     = <<EOT
  {
    "sc_name": "my-storage-creds3",
    "sc_role_arn": "arn:aws:iam::969341422355:role/s3-dbricks-prod-bucket-role",
    "principle_name": "prod-admins",
    "privileges": "ALL PRIVILEGES"
  }
  EOT
  }
  
  locals {
    sc_config = jsondecode(var.sc_config_json)
  }