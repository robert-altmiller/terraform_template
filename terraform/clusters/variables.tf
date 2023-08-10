# github actor / username
variable "github_actor" {
  description = "user who is initiating the github actions workflow"
  type = string
}

# deployment environment
variable "environment" {
  description = "deployment environment"
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