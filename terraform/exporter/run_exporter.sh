# Instructions1 -->
# if you want to just export the results for one workspace artifact (e.g. secrets) remove the "=" and put a space instead like in the example below

# export DATABRICKS_HOST=https://adb-4247081124391553.13.azuredatabricks.net/
# export DATABRICKS_TOKEN=XXXXXXXXX
# ./terraform-provider-databricks_1.85.0_darwin_amd64/terraform-provider-databricks_v1.84.0 exporter -skip-interactive \
# -directory ./exporter_results \
# -services secrets \
# -listing secrets \
# -debug 2>&1 |tee tr_exporter_logs

# Instructions2 -->
# if you want to export more than one workspace artifact (e.g. secret, jobs, workflows, groups, etc) remove the space and put an equals like in the example below:

# export DATABRICKS_HOST=https://abc-123.cloud.databricks.com
# export DATABRICKS_TOKEN=<your pat token here>
export DATABRICKS_HOST=https://adb-4247081124391553.13.azuredatabricks.net/
export DATABRICKS_TOKEN=XXXXXXXXXXXX
./terraform-provider-databricks_1.85.0_darwin_amd64/terraform-provider-databricks_v1.85.0 exporter \
    -directory ./exporter_results \
    -services=groups,secrets,access,compute,users,jobs,storage \
    -listing=jobs,compute \
    -last-active-days=90 \
    -module=data_platform \
    -debug
# sh import.sh

# These commands below will produce counts of artifacts deployed in Databricks
cd exporter_results
grep -rh 'resource "' *.tf | awk '{print $2}' | sort | uniq -c | awk '{print $2, $1}'