#!/bin/bash

# Run terraform plan and save the output to a file
terraform plan -detailed-exitcode > plan_output.txt 2>&1

# Check the exit code
exit_code=${PIPESTATUS[0]}
case $exit_code in
  0)
    echo "No changes."
    ;;
  1)
    echo "Error running terraform plan."
    ;;
  2)
    echo "Changes to be made:"
    # Use grep and awk to extract and summarize the changes
    cat plan_output.txt | grep -E '\s+[~+-]' | awk '{print $1 " " $2}' | sort | uniq -c
    ;;
  *)
    echo "Unknown exit code."
    ;;
esac

# Clean up the temporary file
rm plan_output.txt
