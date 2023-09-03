# create databricks storage credential (UC)
resource "databricks_storage_credential" "external" {
  for_each = local.sc_config.storage_credentials
  provider  = databricks.workspace
  name      = try("${each.value.resource_name}-${var.environment}", "n/a")
  aws_iam_role {
    role_arn = try(each.value.sc_role_arn, "n/a")
  }
  comment = "Managed by Terraform (TF)"
}

resource "databricks_grants" "credential_grants" {
  # count = var.databricks_deploy_uc_storage_credential == "true" ? 1 : 0 # used as a conditional because of 'databricks_storage_credential.external.id'
  for_each = local.sc_config.storage_credentials
  provider           = databricks.workspace
  storage_credential = databricks_storage_credential.external[each.key].id
  grant {
    principal  = try("${var.environment}-${each.value.sc_principal_name}", "n/a")
    privileges = try(each.value.sc_principal_privileges, "n/a")
  }
}