# # required terraform providers
# terraform {
#   required_providers {
#     aws = "~> 3.0"
#   }
# }

# # configure the aws provider
# provider "aws" {
#   region     = var.AWS_REGION
#   access_key = var.AWS_ACCESS_KEY_ID
#   secret_key =  var.AWS_SECRET_ACCESS_KEY
# }

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
