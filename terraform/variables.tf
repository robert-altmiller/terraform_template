# github actor / username
variable "github_actor" {
  description = "User who is initiating the github actions workflow"
  type = string
}

# deployment environment
variable "environment" {
  description = "deployment environment"
  type        = string
}

# source directory
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

# databricks account id
variable "databricks_account_id" {
  description = "DATABRICKS_ACCOUNT_ID secret passed from GitHub Actions"
  type        = string
}

# databricks instance environment variable
variable "databricks_instances" {
  description = "maps of Databricks instances secret passed from GitHub Actions"
  type        = map(string)
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

# databricks token
variable "databricks_token" {
  description = "DATABRICKS_AUTH_TOKEN secret passed from Github Actions"
  type = string
}

# databricks deploy clusters
variable "databricks_deploy_clusters" {
  description = "create and deploy databricks clusters"
  type = string
  default = "false"
}

# databricks deploy cluster policies
variable "databricks_deploy_cluster_policies" {
  description = "create and deploy databricks cluster policies"
  type = string
  default = "false"
}

# databricks deploy uc storage credential
variable "databricks_deploy_uc_storage_credential" {
  description = "create and deploy uc storage credentials"
  type = string
  default = "false"
}

# databricks deploy uc storage credential
variable "databricks_deploy_uc_schema" {
  description = "create and deploy uc schema"
  type = string
  default = "false"
}

# databricks submission json for infrastructure changes
variable "databricks_submission_json" {
  description = "databricks submissions json"
  type = string
}