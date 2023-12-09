# create databricks catalog (UC)
resource "databricks_catalog" "catalog" {
  for_each  = jsondecode(var.databricks_submission_json)["catalogs"]
  metastore_id = try(each.value["catalog_metastore_id"], "")
  provider  = databricks.workspace
  name         = try(each.value["resource_name"], "")
  storage_root = try(each.value["el_resource_name"], "")
  comment  = "Managed by Terraform (TF)"
  owner        = var.databricks_client_id
  force_destroy = true
}

# grant use schema to the service principal (e.g. catalog_grants)
resource "databricks_grants" "catalog_grants" {
  depends_on = [databricks_catalog.catalog]
  for_each  = jsondecode(var.databricks_submission_json)["catalogs"]
  provider  = databricks.workspace
  catalog = databricks_catalog.catalog[each.key].id

  grant {
    principal  = try(each.value["catalog_principal_name"], "")
    privileges = try(each.value["catalog_principal_privileges"], [""])
  }
  grant {
    principal  = var.databricks_client_id
    privileges = ["ALL_PRIVILEGES"]
  }
}