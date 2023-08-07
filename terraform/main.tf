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