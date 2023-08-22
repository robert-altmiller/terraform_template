# create databricks storage credential (UC)
resource "databricks_storage_credential" "external" {
  provider = databricks.workspace
  name = "${local.sc_config.sc_name}-${var.environment}"
  aws_iam_role {
    role_arn = local.sc_config.sc_role_arn
  }
  comment = "Managed by Terraform (TF)"
}

# add databricks grants on storage credential (UC)
resource "databricks_grants" "credential_grants" {
  depends_on = [databricks_storage_credential.external]
  #count = var.databricks_deploy_uc_storage_credential == "true" ? 1 : 0 # used as a conditional because of 'databricks_storage_credential.external.id'
  provider = databricks.workspace
  storage_credential = databricks_storage_credential.external.id
  grant {
    principal  = "${var.environment}-${local.sc_config.sc_principal_name}"
    privileges = local.sc_config.sc_principal_privileges
  }
}