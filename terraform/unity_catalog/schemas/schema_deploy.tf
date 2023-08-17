
# grant use schema to the service principal (e.g. catalog_grants)
resource "databricks_grants" "catalog_grants" {
  provider = databricks.workspace
  catalog = local.schema_config.catalog_name
  grant {
    principal  = local.schema_config.schema_principal_name
    privileges = local.schema_config.catalog_principal_privileges
  }
}

# databricks_schema (UC)
resource "databricks_schema" "schema" {
  provider = databricks.workspace
  count = var.databricks_deploy_uc_schema == "true" ? 1 : 0 # used as a conditional
  catalog_name = local.schema_config.catalog_name
  name         = local.schema_config.schema_name 
}

# databricks_grants on schema (UC)
resource "databricks_grants" "schema_grants" {
  provider = databricks.workspace
  schema = "${local.schema_config.catalog_name}.${local.schema_config.schema_name}"
  grant {
    principal  = local.schema_config.schema_principal_name
    privileges = local.schema_config.schema_principal_privileges
  }
}