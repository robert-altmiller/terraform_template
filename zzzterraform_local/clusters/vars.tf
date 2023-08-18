variable "github_actor" {
  description = "user who is initiating the github actions workflow"
  type = string
}

variable "environment" {
  description = "deployment environment"
  type        = string
}

# variable "databricks_account_id" {
#   description = "databricks account id"
#   type        = string
# }

variable "databricks_instance" {
  description = "databricks instance url"
  type        = string
}

variable "databricks_admin_login" {
  description = "databricks admin login"
  type        = string
}

variable "databricks_admin_password" {
  description = "databricks admin password"
  type        = string
}

variable "databricks_client_id" {
  description = "databricks client id"
  type        = string
}

variable "databricks_client_secret" {
  description = "databricks client secret"
  type        = string
}

variable "databricks_token" {
  description = "databricks token"
  type        = string
}

# ----------variables for module instantiation----------

variable "databricks_deploy_clusters" {
  description = "Set to true to execute the cluster module, false to skip."
  type        = string
}