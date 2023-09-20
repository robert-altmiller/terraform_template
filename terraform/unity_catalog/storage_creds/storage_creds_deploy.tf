# # create databricks storage credential (UC)
# resource "databricks_storage_credential" "external" {
#   for_each  = jsondecode(var.databricks_submission_json)["storage_credentials"]
#   provider  = databricks.workspace
#   name      = tostring(lookup(each.value, "resource_name", ""))
#   aws_iam_role {
#     role_arn = tostring(lookup(each.value, "sc_role_arn", ""))
#   }
#   comment = "Managed by Terraform (TF)"
# }

# resource "databricks_grants" "credential_grants" {
#   # count = var.databricks_deploy_uc_storage_credential == "true" ? 1 : 0 # used as a conditional because of 'databricks_storage_credential.external.id'
#   for_each           = jsondecode(var.databricks_submission_json)["storage_credentials"]
#   provider           = databricks.workspace
#   storage_credential = databricks_storage_credential.external[each.key].id
#   grant {
#     principal  = tostring(lookup(each.value, "sc_principal_name", ""))
#     privileges = lookup(each.value, "sc_principal_privileges", null) != null ? each.value.sc_principal_privileges : [""]
#   }
# }

# create databricks storage credential (UC)
resource "databricks_storage_credential" "external" {
  for_each  = jsondecode(var.databricks_submission_json)["storage_credentials"]
  provider  = databricks.workspace
  name      = try(each.value["resource_name"], "")
  aws_iam_role {
    role_arn = try(each.value["sc_role_arn"], "")
  }
  comment   = "Managed by Terraform (TF)"
}

resource "databricks_grants" "credential_grants" {
  for_each           = jsondecode(var.databricks_submission_json)["storage_credentials"]
  provider           = databricks.workspace
  storage_credential = databricks_storage_credential.external[each.key].id
  grant {
    principal  = try(each.value["sc_principal_name"], "")
    # Return the actual privileges if available, otherwise default to an empty list
    privileges = try(each.value["sc_principal_privileges"], [""])
  }
}