# Nationwide Terraform Databricks Deployment Template

### This repo is an attempt at creating a Terraform deployment methodology that makes it easy to deploy Databricks resources in blocks that can be enabled or disabled at Github Workflow runtime while maintaining a single instance of the terraform state file.  In the workflow manual run parameters you can set the deployment environment ad __dev__ or __prod__ and also if you want to deploy a Databricks cluster to one of these environments.  We have implemented some best practices for parameterization and abstacted away the secrets in the Github repository

### link to Github repo: https://github.com/robert-altmiller/nationwide_terraform

## Step 1: In order to run the Terraform code in this repository you will need to first set the secret values under the Github repo settings:

![github_secrets.png](/readme_images/github_secrets.jpg)

## Step 2: Run the Github workflow to deploy cluster to Databricks workspace

![run_workflow1.png](/readme_images/run_workflow1.jpg)

![run_workflow2.png](/readme_images/run_workflow2.jpg)

## Step 3: Monitor Github workflow for deployment progress status

