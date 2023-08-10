# required terraform providers
terraform {
  required_providers {
    aws = "~> 3.0"
  }
  # required_version = ">=0.12.9"
}

# configure the aws provider
provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key_id
  secret_key =  var.aws_secret_access_key
}