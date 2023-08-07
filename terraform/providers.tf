# required terraform providers
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

# configure the aws provider
provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key_id
  secret_key =  var.aws_secret_access_key
}