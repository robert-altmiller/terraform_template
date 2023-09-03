# create databricks storage credential (UC)
resource "databricks_storage_credential" "external" {
  for_each = local.sc_config.storage_credentials
  provider  = databricks.workspace
  name      = "${each.value.sc_name}-${var.environment}"
  aws_iam_role {
    role_arn = each.value.sc_role_arn
  }
  comment = "Managed by Terraform (TF)"
}

resource "databricks_grants" "credential_grants" {
  # count = var.databricks_deploy_uc_storage_credential == "true" ? 1 : 0 # used as a conditional because of 'databricks_storage_credential.external.id'
  for_each = local.sc_config.storage_credentials
  provider           = databricks.workspace
  storage_credential = databricks_storage_credential.external[each.key].id
  grant {
    principal  = "${var.environment}-${each.value.sc_principal_name}"
    privileges = each.value.sc_principal_privileges
  }
}