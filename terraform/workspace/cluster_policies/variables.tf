variable "github_actor" {
  description = "user who is initiating the github actions workflow"
  type = string
}

variable "databricks_instance" {
  description = "databricks instance url"
  type        = string
}

variable "databricks_token" {
  description = "databricks token"
  type        = string
}

variable "databricks_submission_json" {
  description = "json submission for infrastructure changes"
  type        = string
}