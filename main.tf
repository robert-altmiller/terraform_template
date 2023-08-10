locals {
  source_dir_unredacted = "${var.source_dir}"
}

locals {
  aws_region_redacted = "REDACTED${var.aws_region}"
}

locals {
  aws_access_key_id_redacted = "REDACTED${var.aws_access_key_id}"
}


locals {
  aws_access_key_secret_redacted = "REDACTED${var.aws_access_key_secret}"
}

output "source_dir_output" {
  value = local.source_dir_unredacted
  description = "un-redacted version of source_dir"
}

output "aws_region_output" {
  value = local.aws_region_redacted
  description = "redacted version of aws_region"
}

output "aws_access_key_id_output" {
  value = local.aws_access_key_id_redacted
  description = "redacted version of aws_access_key_id"
}

output "aws_access_key_secret_output" {
  value = local.aws_access_key_secret_redacted
  description = "redacted version of aws_access_key_secret"
}