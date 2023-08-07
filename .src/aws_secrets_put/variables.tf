# aws region environment variable
variable "AWS_REGION" {
  description = "AWS_REGION passed from GitHub Actions"
  type        = string
  default     = "None"
}

# aws access key id environment variable
variable "AWS_ACCESS_KEY_ID"{
  description = "AWS_ACCESS_KEY passed from GitHub Actions"
  type        = string
  default     = "None"
}

# aws secret access key  environment variable
variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS_SECRET_ACCESS_KEY passed from GitHub Actions"
  type        = string
  default     = "None"
}

