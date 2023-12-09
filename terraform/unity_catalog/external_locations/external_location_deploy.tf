# create databricks external location
resource "databricks_external_location" "ext_loc" {
  for_each  = jsondecode(var.databricks_submission_json)["external_locations"]
  provider  = databricks.workspace
  name            = try(each.value["resource_name"], "")
  url             = try(each.value["el_s3_url"], "")
  credential_name = try(each.value["el_sc_name"], "")
  comment         = "Managed by Terraform (TF)"
  owner           = var.databricks_client_id
  force_destroy   = true
}

# external location grants
resource "databricks_grants" "ext_loc_grants" {
  depends_on = [databricks_external_location.ext_loc]
  for_each  = jsondecode(var.databricks_submission_json)["external_locations"]
  provider  = databricks.workspace
  external_location = databricks_external_location.ext_loc[each.key].id
  
  grant {
    principal  = try(each.value["el_principal_name"], "")
    privileges = try(each.value["el_principal_privileges"], [""])
  }
  grant {
    principal  = var.databricks_client_id
    privileges = ["ALL_PRIVILEGES"]
  }
}