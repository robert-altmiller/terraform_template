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
      version = "~> 5.0"
    }
  }
}

# configure the aws provider
provider "aws" {
  region     = local.aws_region_output
  access_key = local.aws_access_key_id_output
  secret_key =  local.aws_secret_access_key_output
}