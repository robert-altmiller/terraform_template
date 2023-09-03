
# # grant use schema to the service principal (e.g. catalog_grants)
# resource "databricks_grants" "catalog_grants" {
#   provider = databricks.workspace
#   catalog = local.schema_config.catalog_name
#   grant {
#     principal  = var.databricks_client_id
#     privileges = local.schema_config.catalog_principal_privileges
#   }
# }

# # create databricks schema (UC)
# resource "databricks_schema" "schema" {
#   count = var.databricks_deploy_uc_schema == "true" ? 1 : 0 # used as a conditional
#   provider = databricks.workspace
#   catalog_name = local.schema_config.catalog_name
#   name         = local.schema_config.schema_name 
# }

# # add databricks grants on schema (UC)
# resource "databricks_grants" "schema_grants" {
#   provider = databricks.workspace
#   schema = "${local.schema_config.catalog_name}.${local.schema_config.schema_name}"
#   grant {
#     principal  = "${var.environment}-${local.schema_config.schema_principal_name}"
#     privileges = local.schema_config.schema_principal_privileges
#   }
# }

# grant use schema to the service principal (e.g. catalog_grants)
resource "databricks_grants" "catalog_grants" {
  for_each  = local.schema_config.schemas
  provider  = databricks.workspace
  catalog   = try(each.value.catalog_name, "n/a")
  grant {
    principal  = try(each.value.catalog_principal_name, "n/a")
    privileges = try(each.value.catalog_principal_privileges, "n/a")
  }
}

# create databricks schema (UC)
resource "databricks_schema" "schema" {
  for_each    =  local.schema_config.schemas
  provider    = databricks.workspace
  catalog_name= try(each.value.catalog_name, "n/a")
  name        = try(each.value.resource_name, "n/a")
}

# add databricks grants on schema (UC)
resource "databricks_grants" "schema_grants" {
  for_each  = local.schema_config.schemas
  provider  = databricks.workspace
  schema    = try("${each.value.catalog_name}.${each.value.resource_name}", "n/a")
  grant {
    principal  = try("${var.environment}-${each.value.schema_principal_name}", "n/a")
    privileges = try(each.value.schema_principal_privileges, "n/a")
  }
}
