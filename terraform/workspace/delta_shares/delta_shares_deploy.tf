# create a new databricks delta sharing share
resource "databricks_share" "create_delta_share" {
  for_each = jsondecode(var.databricks_submission_json)["delta_shares"]
  provider = databricks.workspace
  name = try(each.value["resource_name"], "")
}

# used for delta sharing external recipient
resource "random_password" "db2opensharecode" {
  length  = 16
  special = true
}

# add a delta sharing external recipient
resource "databricks_recipient" "delta_share_external_recipient" {
  for_each = local.valid_delta_shares_external
  provider = databricks.workspace
  name = try(each.value["ds_recipient_name_external"], "")
  comment             = "Managed by Terraform (TF)" 
  authentication_type = "TOKEN"
  sharing_code        = random_password.db2opensharecode.result
  # ip_access_list {
  #   allowed_ip_addresses = [] // .. fill in allowed IPv4 addresses (CIDR notation allowed)
  # }
}

resource "databricks_recipient" "delta_share_databricks_recipient" {
  for_each = local.valid_delta_shares_databricks
  provider = databricks.workspace
  name     = try(each.value["ds_recipient_name_databricks"], "")
  comment                            = "Managed by Terraform (TF)"
  authentication_type                = "DATABRICKS"
  data_recipient_global_metastore_id = try(each.value["ds_sharing_identifier"], "")
}

# grant delta sharing recipient access to the share
resource "databricks_grants" "delta_sharing_grants" {
  depends_on = [databricks_share.create_delta_share]
  for_each   = jsondecode(var.databricks_submission_json)["delta_shares"]
  provider   = databricks.workspace
  share      = databricks_share.create_delta_share[each.key].name

  dynamic "grant" {
    for_each = contains(keys(local.valid_delta_shares_external), each.key) ? [1] : []
    content {
      principal  = databricks_recipient.delta_share_external_recipient[each.key].name
      privileges = ["SELECT"]
    }
  }

  dynamic "grant" {
    for_each = contains(keys(local.valid_delta_shares_databricks), each.key) ? [1] : []
    content {
      principal  = databricks_recipient.delta_share_databricks_recipient[each.key].name
      privileges = ["SELECT"]
    }
  }
}