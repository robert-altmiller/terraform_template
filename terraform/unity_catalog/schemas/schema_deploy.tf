resource "databricks_sql_database" "unity_catalog_schema" {
  count = var.databricks_deploy_uc_schema == "true" ? 1 : 0 # used as a conditional
  name = local.schema_config.schema_name
}

# resource "databricks_sql_table" "unity_catalog_table" {
#   database_id = databricks_sql_database.unity_catalog_db.id
#   name        = "unity_catalog_table"
#   sql         = "CREATE TABLE IF NOT EXISTS unity_catalog_table (id INT, name STRING)"
# }
