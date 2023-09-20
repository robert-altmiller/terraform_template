# grant use schema to the service principal (e.g. catalog_grants)
resource "databricks_grants" "catalog_grants" {
  for_each  = jsondecode(var.databricks_submission_json)["schemas"]
  provider  = databricks.workspace
  catalog   = try(each.value.catalog_name, "n/a")
  grant {
    principal  = var.databricks_client_id
    privileges = try(each.value.catalog_principal_privileges, "n/a")
  }
}

# create databricks schema (UC)
resource "databricks_schema" "schema" {
  for_each    =  jsondecode(var.databricks_submission_json)["schemas"]
  provider    = databricks.workspace
  catalog_name= try(each.value.catalog_name, "n/a")
  name        = try(each.value.resource_name, "n/a")
}

# add databricks grants on schema (UC)
resource "databricks_grants" "schema_grants" {
  for_each  = jsondecode(var.databricks_submission_json)["schemas"]
  provider  = databricks.workspace
  schema    = try("${each.value.catalog_name}.${each.value.resource_name}", "n/a")
  grant {
    principal  = try("${var.environment}-${each.value.schema_principal_name}", "n/a")
    privileges = try(each.value.schema_principal_privileges, "n/a")
  }
}
