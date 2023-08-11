# Nationwide Terraform Databricks Deployment Template

### This repo is an attempt at creating a Terraform deployment methodology that makes it easy to deploy Databricks resources in blocks that can be enabled or disabled at Github Workflow runtime while maintaining a single instance of the terraform state file.  In the workflow manual run parameters you can set the deployment environment ad dev or prod and also if you want to deploy a Databricks cluster to one of these environments.  We have implemented some best practices for parameterization and abstacted away the secrets in the Github repository

### link to Github repo: https://github.com/robert-altmiller/nationwide_terraform

### In order to run the Terraform code in this repository you will need to first set the secret values under the Github repo settings:

![github_secrets.png](/readme_images/github_secrets.jpg)