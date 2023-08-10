# aws region environment variable
variable "environment" {
  description = "deployment environment"
  type        = string
}

variable "source_dir" {
  description = "local github repo source directory"
  type        = string
  default     = "terraform"
}

# aws region environment variable
variable "aws_region" {
  description = "AWS_REGION secret passed from GitHub Actions"
  type        = string
}

# aws access key id environment variable
variable "aws_access_key_id"{
  description = "AWS_ACCESS_KEY secret passed from GitHub Actions"
  type        = string
}

# aws secret access key environment variable
variable "aws_access_key_secret" {
  description = "AWS_SECRET_ACCESS_KEY secret passed from GitHub Actions"
  type        = string
}

# databricks instance environment variable
variable "databricks_instance" {
  description = "DATABRICKS_INSTANCE secret passed from GitHub Actions"
  type        = string
}

# databricks admin login environment variable
variable "databricks_admin_login" {
  description = "DATABRICKS_ADMIN_LOGIN secret passed from GitHub Actions"
  type        = string
}

# databricks admin password environment variable
variable "databricks_admin_password" {
  description = "DATABRICKS_ADMIN_PASSWORD secret passed from GitHub Actions"
  type        = string
}

# databricks client id environment variable (e.g. service principle id)
variable "databricks_client_ids" {
  description = "Map of Databricks client ids for different environments"
  type = map(string)
}

# databricks client secret environment variable (e.g. service principle secret)
variable "databricks_client_secrets" {
  description = "Map of Databricks client secrets for different environments"
  type = map(string)
}
