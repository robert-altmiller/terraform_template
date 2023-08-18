## Nationwide Terraform Deployment Template

### This repo contains a Terraform deployment methodology that makes it easy to deploy Databricks resources in blocks that can be enabled, disabled or destroyed at Github workflow runtime while maintaining a single instance of the terraform state file across environments (e.g. dev/prod).  In the workflow manual run parameters you can set the deployment environment to dev or prod.  Each of these environments will be managed with it's own 'Terraform.tfstate' json file in separate AWS S3 buckets for dev and prod environments.  Within the chosen environment you can select to deploy or destroy the following resources: clusters, cluster policies, unity catalog schema, and unity catalog storage credentials.  We have implemented some best practices for parameterization and abstacted away the secrets in the Github repository secrets.

### Link to Github repository: https://github.com/robert-altmiller/nationwide_terraform
 
### Different ways to use this Terraform template

- Template can be used as a reference for how to structure and organize deployments of Databricks account and workspace level resources in a modular fashion.  By modularity we mean you can choose what Databricks resources to deploy, ingnore, or destroy in a single Github workflow run while maintaining updates and changes to one single 'terraform.tfstate' json file.

- You can also create two brand new dev and prod AWS Databricks workspaces, create service principals and groups for each of those workspaces in the Databricks account console, update all secrets in a forked github repo, and run the terraform template to deploy clusters, cluster policies, unity catalog schemas and storage credentials.  After you get this working and understand the structure of this Terraform template.  It can easily be extended to deploy additional Databricks account and workspace level resources.

- See the end of this 'README.md' for details about how to setup two brand new Databricks workspaces, groups, service principals, and resource grants prior to Terraform template execution.

## How do I run the Github workflow?

### Step 1: In order to run the Terraform code in this repository you will need to first set the secret values under the Github repo settings

![github_secret.png](/readme_images/github_secret.jpg)

### Step 2: Run the Github workflow to deploy cluster to Databricks workspace

![run_workflow.jpg](/readme_images/run_workflow.jpg)

### Step 3: Monitor Github workflow for deployment progress status

![monitor_workflows1.jpg](/readme_images/monitor_workflows1.jpg)

![monitor_workflows2.jpg](/readme_images/monitor_workflows2.jpg)

![monitor_workflows3.jpg](/readme_images/monitor_workflows3.jpg)

## How do I setup dev and prod Databricks workspaces for Terraform Template?

### Step 1: Deploy two workspaces through the Databricks admin console using the 'quickstart (recommended)' option.  After these two Databricks workspaces get provisioned they will automatically be Unity Catalog (UC) enabled workspaces.

- Name the workspace 'my-workspace-dev' and 'my-workspace-prod'

![dbricks_prerequisite1.jpg](/readme_images/dbricks_prerequisite1.jpg)

### Step 2: In the Databricks admin console create 3 groups for dev, and 3 groups for prod workspaces and a service principle for each workspace.

- Create the following groups: 'dev-readers', 'dev-contributors', 'dev-admins', 'prod-readers', 'prod-contributors', and 'prod-admins'

![dbricks_prerequisite2a.jpg](/readme_images/dbricks_prerequisite2a.jpg)

- Create the following service principals: 'my-sp-dev' and 'my-sp-prod'

![dbricks_prerequisite2b.jpg](/readme_images/dbricks_prerequisite2b.jpg)

### Step 2: Add the 'dev' groups and 'dev' service principal to the 'dev' workspace, and add the 'prod' groups and 'prod' service principal to the 'prod' workspace

- Open the 'prod' workspace from the Databricks account console

![dbricks_prerequisite3a.jpg](/readme_images/dbricks_prerequisite3a.jpg)

- Open the 'Admin Settings' after logging into the 'my-workspace-prod' Databricks workspace

![dbricks_prerequisite3b.jpg](/readme_images/dbricks_prerequisite3b.jpg)

- Add the 'prod' groups to the 'my-workspace-prod' Databricks workspace

![dbricks_prerequisite3c.jpg](/readme_images/dbricks_prerequisite3c.jpg)

- Add the 'prod' service principal to the 'my-workspace-prod' Databricks workspace

![dbricks_prerequisite3d.jpg](/readme_images/dbricks_prerequisite3d.jpg)

#### **** IMPORTANT **** Do the same steps above in 'step 2' for the 'my-workspace-dev' Databricks workspace.

### Step 3: Add service principals to groups and grant groups permission to access, modify, and update Databricks workspace resources

- Add 'dev' and 'prod' service principals to the 'prod-admins' group, and add the 'prod-contributors' group into the 'prod-readers' group in the 'my-workspace-prod' Databricks workspace.

![dbricks_prerequisite4a.jpg](/readme_images/dbricks_prerequisite4a.jpg)

![dbricks_prerequisite4b.jpg](/readme_images/dbricks_prerequisite4b.jpg)

- Add entitlements 'Allow cluster creation', 'Databricks SQL access' and 'Workspace access' to service 'prod' service principal in the 'my-workspace-prod' Databricks workspace.

![dbricks_prerequisite4c.jpg](/readme_images/dbricks_prerequisite4c.jpg)

- Update the 'main' catalog owner to 'dev-admins' or 'prod-admins'.  It won't matter because both the 'dev' and 'prod' service principals are in both groups.  The service principal needs to be an owner on the catalog in order to create a schema beneath it and grant permissions to it.

![dbricks_prerequisite4d.jpg](/readme_images/dbricks_prerequisite4d.jpg)

#### **** IMPORTANT *** Do the same steps above in 'step 3' for the 'my-workspace-dev' Databricks workspace.

#### Once you have completed all these steps above you will be ready to run this Terraform template out of the box.

### Appendix

[How to setup a storage credential on AWS](https://docs.databricks.com/en/data-governance/unity-catalog/manage-external-locations-and-credentials.html#manage-storage-credentials)

[Dropdown for GitHub workflows input parameters](https://arthurbdiniz.com/github/actions/workflows/2021/10/23/gh-action-dropdown.html)

[How to use 'foreach' with Databricks grants](https://discuss.hashicorp.com/t/how-to-use-for-each-with-databricks-grants-resource/54592)