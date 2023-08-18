## Nationwide Terraform Deployment Template

### This repo contains a Terraform deployment methodology that makes it easy to deploy Databricks resources in blocks that can be enabled, disabled or destroyed at Github workflow runtime while maintaining a single instance of the terraform state file across environments (e.g. dev/prod).  In the workflow manual run parameters you can set the deployment environment to dev or prod.  Each of these environments will be managed with it's own 'Terraform.tfstate' json file in separate AWS S3 buckets for dev and prod environments.  Within the chosen environment you can select to deploy or destroy the following resources: clusters, cluster policies, unity catalog schema, and unity catalog storage credentials.  We have implemented some best practices for parameterization and abstacted away the secrets in the Github repository secrets.

### Link to Github repository: https://github.com/robert-altmiller/nationwide_terraform
 
### Different ways to use this Terraform template

- Template can be used as a reference for how to structure and organize deployments of Databricks account and workspace level resources in a modular fashion.  By modularity we mean you can choose what Databricks resources to deploy, ingnore, or destroy in a single Github workflow run while maintaining updates and changes to one single 'terraform.tfstate' json file.

- You can also create two brand new dev and prod AWS Databricks workspaces, create service principals and groups for each of those workspaces in the Databricks account console, update all secrets in a forked github repo, and run the terraform template to deploy clusters, cluster policies, unity catalog schemas and storage credentials.  After you get this working and understand the structure of this Terraform template.  It can easily be extended to deploy additional Databricks account and workspace level resources.

- See the end of this README.md for details about how to setup two brand new Databricks workspaces, groups, service principals, and resource grants prior to Terraform template execution.

### Step 1: In order to run the Terraform code in this repository you will need to first set the secret values under the Github repo settings

![github_secret.png](/readme_images/github_secret.jpg)

### Step 2: Run the Github workflow to deploy cluster to Databricks workspace

![run_workflow.jpg](/readme_images/run_workflow.jpg)

### Step 3: Monitor Github workflow for deployment progress status

![monitor_workflows1.jpg](/readme_images/monitor_workflows1.jpg)

![monitor_workflows2.jpg](/readme_images/monitor_workflows2.jpg)

![monitor_workflows3.jpg](/readme_images/monitor_workflows3.jpg)

### Appendix

[How to setup a storage credential on AWS](https://docs.databricks.com/en/data-governance/unity-catalog/manage-external-locations-and-credentials.html#manage-storage-credentials)

[Dropdown for GitHub workflows input parameters](https://arthurbdiniz.com/github/actions/workflows/2021/10/23/gh-action-dropdown.html)

[How to use 'foreach' with Databricks grants](https://discuss.hashicorp.com/t/how-to-use-for-each-with-databricks-grants-resource/54592)