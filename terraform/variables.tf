# aws region environment variable
variable "source_dir" {
  description = "local github repo source directory"
  type        = string
  default     = "terraform"
  sensitive   = true
}

# aws region environment variable
variable "aws_region" {
  description = "AWS_REGION secret passed from GitHub Actions"
  type        = string
  sensitive   = true
}

# aws access key id environment variable
variable "aws_access_key_id"{
  description = "AWS_ACCESS_KEY secret passed from GitHub Actions"
  type        = string
  sensitive   = true
}

# aws secret access key  environment variable
variable "aws_access_key_secret" {
  description = "AWS_SECRET_ACCESS_KEY secret passed from GitHub Actions"
  type        = string
  sensitive   = true
}

# aws secret access key  environment variable
variable "databricks_admin_login" {
  description = "DATABRICKS_ADMIN_LOGIN secret passed from GitHub Actions"
  type        = string
  sensitive   = true
}

# aws secret access key  environment variable
variable "databricks_admin_password" {
  description = "DATABRICKS_ADMIN_PASSWORD secret passed from GitHub Actions"
  type        = string
  sensitive   = true
}