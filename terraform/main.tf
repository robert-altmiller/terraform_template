# required terraform providers
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      Version = "~>5.0"
    }
  }
  required_version = ">=0.14.9"
}

# configure the aws provider
provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key_id
  secret_key =  var.aws_secret_access_key
}


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

output "aws_access_key_id_output" {
  value = local.aws_region_redacted
  description = "redacted version of aws_region"
}

output "redacted_secret" {
  value = local.aws_access_key_id_redacted
  description = "redacted version of aws_access_key_id"
}

output "redacted_secret" {
  value = local.aws_access_key_secret_redacted
  description = "redacted version of aws_access_key_secret"
}