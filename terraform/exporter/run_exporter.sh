export DATABRICKS_HOST=https://abc-123.cloud.databricks.com
export DATABRICKS_TOKEN=<your pat token here>
./terraform-provider-databricks_v1.26.0 exporter -skip-interactive \
-directory ./exporter_results \
-services secrets \
-listing secrets \
-debug 2>&1 |tee tr_exporter_logs