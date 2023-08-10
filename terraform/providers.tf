# required terraform providers
terraform {
  required_providers {
    aws = "~> 3.0"
  }
  required_version = ">=0.12.8"
}

# configure the aws provider
provider "aws" {
  region     = local.aws_region
  access_key = local.aws_access_key_id
  secret_key =  local.aws_secret_access_key
}