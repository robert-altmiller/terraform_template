variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "dbricks-dev-bucket"
}

variable "key_name" {
  description = "The key for the terraform state file"
  type        = string
  default     = "terraform/terraform.tfstate"
}

variable "region" {
  description = "The AWS region"
  type        = string
  default     = "us-west-2" # You can change this to your desired default region
}

variable "profile" {
  description = "AWS credentials profile"
  type        = string
  default     = "awscredsprofile"
}

terraform {
  backend "s3" {
    bucket = var.bucket_name
    key = var.key_name
    region = var.region
    shared_credentials_file = "./.aws/credentials"
    profile = var.profile
  }
}

# # terraform backend for terraform state file
# terraform {
#   backend "s3" {
#     bucket = "dbricks-dev-bucket"
#     key = "terraform/terraform.tfstate"
#     region = local.aws_region
#     shared_credentials_file = "./.aws/credentials"
#     profile                 = "awscredsprofile" # Add this line
#   }
# }