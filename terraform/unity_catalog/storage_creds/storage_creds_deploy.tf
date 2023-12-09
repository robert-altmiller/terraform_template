# create databricks storage credential (UC)
resource "databricks_storage_credential" "storage_cred" {
  for_each  = jsondecode(var.databricks_submission_json)["storage_credentials"]
  provider  = databricks.workspace
  name      = try(each.value["resource_name"], "")
  aws_iam_role {
    role_arn = try(each.value["sc_role_arn"], "")
  }
  comment   = "Managed by Terraform (TF)"
  owner     = var.databricks_client_id
  force_destroy = true
}

resource "databricks_grants" "credential_grants" {
  depends_on = [databricks_storage_credential.storage_cred]
  for_each           = jsondecode(var.databricks_submission_json)["storage_credentials"]
  provider           = databricks.workspace
  storage_credential = databricks_storage_credential.storage_cred[each.key].id
  
  grant {
    principal  = try(each.value["sc_principal_name"], "")
    # Return the actual privileges if available, otherwise default to an empty list
    privileges = try(each.value["sc_principal_privileges"], [""])
  }
  grant {
    principal  = var.databricks_client_id
    privileges = ["ALL_PRIVILEGES"]
  }
}