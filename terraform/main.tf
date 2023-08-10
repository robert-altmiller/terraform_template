locals {
  source_dir = "${var.source_dir}"
}

locals {
  aws_region = "${var.aws_region}"
}

locals {
  aws_access_key_id = "${var.aws_access_key_id}"
}


locals {
  aws_access_key_secret = "${var.aws_access_key_secret}"
}

output -json "source_dir_output" {
  value = local.source_dir
  description = "value for source_dir"
}

output -json "aws_region_output" {
  value = local.aws_region
  description = "value for aws_region"
}

output -json "aws_access_key_id_output" {
  value = local.aws_access_key_id
  description = "value for aws_access_key_id"
}

output - json "aws_access_key_secret_output" {
  value = local.aws_access_key_secret
  description = "value for aws_access_key_secret"
}