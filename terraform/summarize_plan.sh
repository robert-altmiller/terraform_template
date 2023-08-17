#!/bin/bash

# Run terraform plan and save the output
plan_output=$(terraform plan -detailed-exitcode)

# Check the exit code
case $? in
  0)
    echo "No changes."
    ;;
  1)
    echo "Error running terraform plan."
    ;;
  2)
    echo "Changes to be made:"
    # Use grep and awk to extract and summarize the changes
    echo "$plan_output" | grep -E '\s+[~+-]' | awk '{print $1 " " $2}' | sort | uniq -c
    ;;
  *)
    echo "Unknown exit code."
    ;;
esac