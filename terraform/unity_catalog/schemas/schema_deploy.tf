# grant use schema to the service principal (e.g. catalog_grants)
resource "databricks_grants" "catalog_grants" {
  for_each  = jsondecode(var.databricks_submission_json)["schemas"]
  provider  = databricks.workspace
  catalog   = try(each.value["catalog_name"], "")
  grant {
    principal  = try(each.value["catalog_principal_name"], "")
    privileges = try(each.value["catalog_principal_privileges"], [""])
  }
  grant {
    principal  = var.databricks_client_id
    privileges = ["ALL_PRIVILEGES"]
  }
}

# create databricks schema (UC)
resource "databricks_schema" "schema" {
  depends_on   = [databricks_grants.catalog_grants]
  for_each     =  jsondecode(var.databricks_submission_json)["schemas"]
  provider     = databricks.workspace
  catalog_name = try(each.value["catalog_name"], "")
  name         = try(each.value["resource_name"], "")
  storage_root = try(each.value["el_resource_name"], "")
  owner        = var.databricks_client_id
  force_destroy = true
}

# add databricks grants on schema (UC)
resource "databricks_grants" "schema_grants" {
  depends_on = [databricks_schema.schema]
  for_each   = jsondecode(var.databricks_submission_json)["schemas"]
  provider   = databricks.workspace
  schema     = try("${each.value.catalog_name}.${each.value.resource_name}", "")
  
  grant {
    principal  = try(each.value["schema_principal_name"], "")
    privileges = try(each.value["schema_principal_privileges"], [""])
  }
  grant {
    principal  = var.databricks_client_id
    privileges = ["ALL_PRIVILEGES"]
  }
}
