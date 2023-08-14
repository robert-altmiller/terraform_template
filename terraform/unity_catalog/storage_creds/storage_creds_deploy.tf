# databricks_storage_credential (UC)
resource "databricks_storage_credential" "external" {
  provider = databricks.workspace
  name = "${local.sc_config.sc_name}-${var.environment}"
  aws_iam_role {
    role_arn = local.sc_config.sc_role_arn
  }
  comment = "Managed by Terraform (TF)"
}

# databricks_grants on storage credential (UC)
resource "databricks_grants" "external_creds" {
  count = var.databricks_deploy_uc_storage_credential == 'true' ? 1 : 0
  provider = databricks.workspace  
  storage_credential = databricks_storage_credential.external.id
  grant {
    principal  = local.sc_config.principle_name
    privileges = [local.sc_config.privileges]
  }
}