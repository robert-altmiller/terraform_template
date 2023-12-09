locals {
  valid_delta_shares_external = {
    for key, value in jsondecode(var.databricks_submission_json)["delta_shares"]: 
    key => value 
    if value.ds_recipient_name_external != null && value.ds_recipient_name_external != ""
  }

  valid_delta_shares_databricks = {
    for key, value in jsondecode(var.databricks_submission_json)["delta_shares"]: 
    key => value 
    if value.ds_recipient_name_databricks != null && value.ds_recipient_name_databricks != "" && value.ds_sharing_identifier != null && value.ds_sharing_identifier != ""
  }
}