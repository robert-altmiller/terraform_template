#!/bin/bash

plan_output=$(terraform plan)

# Extract the operations, resource types, and resource names
actions=$(echo "$plan_output" | grep -E '\s+# [^ ]+ will be' | awk -F' ' '{print $4}')
resources=$(echo "$plan_output" | grep -E '\s+# [^ ]+ will be' | awk -F'# ' '{print $2}' | awk '{print $1}')

# Extract resource types and resource names
resource_types=$(echo "$resources" | awk -F'.' '{print $2}')
resource_names=$(echo "$resources" | awk -F'.' '{print substr($0, index($0,$4))}')

# Display the summarized output in a table
echo -e "Operation\tResource Type\tResource Name"
paste <(echo "$actions") <(echo "$resource_types") <(echo "$resource_names") | column -t
