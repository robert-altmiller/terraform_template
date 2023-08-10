# github actor
locals {
  github_actor = "${var.github_actor}"
}

# deploy environment 
locals {
  environment = "${var.environment}"
}

# source directory
locals {
  source_dir = "${var.source_dir}"
}

# aws region
locals {
  aws_region = "${var.aws_region}"
}

# aws access key id
locals {
  aws_access_key_id = "${var.aws_access_key_id}"
}

# aws access key secret
locals {
  aws_access_key_secret = "${var.aws_access_key_secret}"
}

# dbricks instance url
locals {
  databricks_instance = "${var.databricks_instance}"
}

# dbricks admin login
locals {
  databricks_admin_login = "${var.databricks_admin_login}"
}

# dbricks admin password
locals {
  databricks_admin_password = "${var.databricks_admin_password}"
}

# client id
locals {
  databricks_client_id = lookup("${var.databricks_client_ids}", "${var.environment}")
}

# client secret
locals {
  databricks_client_secret = lookup("${var.databricks_client_secrets}", "${var.environment}")
}

# deploy clusters
locals {
  databricks_deploy_clusters = "${var.databricks_deploy_clusters}"
}
