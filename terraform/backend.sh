#!/bin/bash

# Run terraform init with the arguments
# Terraform backend configuration
terraform init \
  -backend-config="bucket=$BUCKET_NAME" \
  -backend-config="key=$KEY_NAME" \
  -backend-config="region=$AWS_REGION" \
  -backend-config="access_key=$ACCESS_KEY" \
  -backend-config="secret_key=$SECRET_KEY"