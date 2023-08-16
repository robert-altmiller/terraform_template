resource "databricks_sql_database" "unity_catalog_schema" {
  name = local.schema_config.schema_name
}

# resource "databricks_sql_table" "unity_catalog_table" {
#   database_id = databricks_sql_database.unity_catalog_db.id
#   name        = "unity_catalog_table"
#   sql         = "CREATE TABLE IF NOT EXISTS unity_catalog_table (id INT, name STRING)"
# }
