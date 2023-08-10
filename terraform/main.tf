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

output "source_dir_output" {
  value = local.source_dir
  description = "un-redacted version of source_dir"
}

output "aws_region_output" {
  value = local.aws_region
  description = "redacted version of aws_region"
}

output "aws_access_key_id_output" {
  value = nonsensitive(local.aws_access_key_id)
  description = "redacted version of aws_access_key_id"
}

output "aws_access_key_secret_output" {
  value = nonsensitive(local.aws_access_key_secret)
  description = "redacted version of aws_access_key_secret"
}