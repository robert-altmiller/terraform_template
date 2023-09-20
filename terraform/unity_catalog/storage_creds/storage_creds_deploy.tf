# create databricks storage credential (UC)
resource "databricks_storage_credential" "external" {
  for_each = length(jsondecode(var.databricks_submission_json)) > 0 ? jsondecode(var.databricks_submission_json) : {}
  provider  = databricks.workspace
  name      = lookup(each.value, "resource_name", null)
  aws_iam_role {
    role_arn = lookup(each.value, "sc_role_arn", null)
  }
  comment = "Managed by Terraform (TF)"
}

resource "databricks_grants" "credential_grants" {
  # count = var.databricks_deploy_uc_storage_credential == "true" ? 1 : 0 # used as a conditional because of 'databricks_storage_credential.external.id'
  for_each = length(jsondecode(var.databricks_submission_json)) > 0 ? jsondecode(var.databricks_submission_json) : {}
  provider           = databricks.workspace
  storage_credential = databricks_storage_credential.external[each.key].id
  grant {
    principal  = lookup(each.value, "sc_principal_name", null)
    privileges = lookup(each.value, "sc_principal_privileges", null)
  }
}