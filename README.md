## Nationwide Terraform Deployment Template

### This repo contains a Terraform deployment methodology that makes it easy to deploy Databricks resources in blocks that can be enabled or disabled at Github workflow runtime while maintaining a single instance of the terraform state file.  In the workflow manual run parameters you can set the deployment environment ad __dev__ or __prod__ and also if you want to deploy a Databricks cluster to one of these environments.  We have implemented some best practices for parameterization and abstacted away the secrets in the Github repository

### Link to Github repo: https://github.com/robert-altmiller/nationwide_terraform

### Step 1: In order to run the Terraform code in this repository you will need to first set the secret values under the Github repo settings

![github_secrets.png](/readme_images/github_secrets.jpg)

### Step 2: Run the Github workflow to deploy cluster to Databricks workspace

![run_workflow.jpg](/readme_images/run_workflow.jpg)

### Step 3: Monitor Github workflow for deployment progress status

![monitor_workflow1.jpg](/readme_images/monitor_workflow1.jpg)

![monitor_workflow2.jpg](/readme_images/monitor_workflow2.jpg)

![monitor_workflow3.jpg](/readme_images/monitor_workflow3.jpg)