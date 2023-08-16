#!/bin/bash

# Set your variables here
# BUCKET_NAME="dbricks-dev-bucket"
# KEY_NAME="terraform/terraform.tfstate"
# REGION="us-west-2"
# PROFILE="awscredsprofile"

# Run terraform init with the arguments
terraform init \
  -backend-config="bucket=$BUCKET_NAME" \
  -backend-config="key=$KEY_NAME" \
  -backend-config="region=$AWS_REGION" \
  -backend-config="access_key=$ACCESS_KEY" \
  -backend-config="secret_key=$SECRET_KEY" \
  # -backend-config="shared_credentials_file=./.aws/credentials" \
  # -backend-config="profile=$PROFILE"