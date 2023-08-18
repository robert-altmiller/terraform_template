
# grant use schema to the service principal (e.g. catalog_grants)
resource "databricks_grants" "catalog_grants" {
  provider = databricks.workspace
  catalog = local.schema_config.catalog_name
  grant {
    principal  = var.databricks_client_id
    privileges = local.schema_config.catalog_principal_privileges
  }
}

# create databricks schema (UC)
resource "databricks_schema" "schema" {
  count = var.databricks_deploy_uc_schema == "true" ? 1 : 0 # used as a conditional
  provider = databricks.workspace
  catalog_name = local.schema_config.catalog_name
  name         = local.schema_config.schema_name 
}

# add databricks grants on schema (UC)
resource "databricks_grants" "schema_grants" {
  provider = databricks.workspace
  schema = "${local.schema_config.catalog_name}.${local.schema_config.schema_name}"
  grant {
    principal  = "${var.environment}-${local.schema_config.principal_name}"
    privileges = local.schema_config.schema_principal_privileges
  }
}