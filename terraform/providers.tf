# required terraform providers
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"  # Adjust this to the desired version or range
    }
  }
}

# configure the aws provider
provider "aws" {
  region     = var.AWS_REGION
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key =  var.AWS_SECRET_ACCESS_KEY
}