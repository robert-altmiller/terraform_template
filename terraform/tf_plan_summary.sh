#!/bin/bash

plan_output=$(terraform plan)

# Extract the actions and resources
actions=$(echo "$plan_output" | grep -E '\s+# [^ ]+ will be' | awk -F' ' '{print $3}')
resources=$(echo "$plan_output" | grep -E '\s+# [^ ]+ will be' | awk -F'# ' '{print $2}' | awk '{print $1}')

# Display the summarized output in a table
echo -e "Operation\tResource Type\tResource Name"
paste <(echo "$actions") <(echo "$resources") | column -t