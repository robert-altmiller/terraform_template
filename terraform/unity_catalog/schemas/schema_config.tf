# schema config
locals {
  schema_config = jsonencode(var.databricks_submission_json)
}