# Instructions1 -->
# if you want to just export the results for one workspace artifact (e.g. secrets) remove the "=" and put a space instead like in the example below

export DATABRICKS_HOST=https://abc-123.cloud.databricks.com
export DATABRICKS_TOKEN=<your pat token here>
./terraform-provider-databricks_v1.26.0 exporter -skip-interactive \
-directory ./exporter_results \
-services secrets \
-listing secrets \
-debug 2>&1 |tee tr_exporter_logs

# Instructions2 -->
# if you want to export more than one workspace artifact (e.g. secret, jobs, workflows, groups, etc) remove the space and put an equals like in the example below:

# export DATABRICKS_HOST=https://abc-123.cloud.databricks.com
# export DATABRICKS_TOKEN=<your pat token here>
# ./terraform-provider-databricks exporter \
#     -services=groups,secrets,access,compute,users,jobs,storage \
#     -listing=jobs,compute \
#     -last-active-days=90 \
#     -module=data_platform \
#     -debug
# sh import.sh