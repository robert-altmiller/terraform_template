#!/bin/bash

plan_output=$(terraform plan)

# Filter out the relevant section of the terraform plan output
relevant_section=$(echo "$plan_output" | awk '/Terraform will perform the following actions:/,/Plan:/{print}')

# Extract the operations, resource types, resource names, and resource ids
resource_entries=$(echo "$relevant_section" | grep -E '\s+# [^ ]+ will be')
operations=$(echo "$resource_entries" | awk -F' ' '{print $4}')
resource_ids=$(echo "$relevant_section" | grep -E '^\s+- id[ \t]*=' | awk -F'= ' '{print $2}' | tr -d '"' | tr -d '-> null')

# Extract resource types and resource names
resource_types=$(echo "$resource_entries" | awk -F'# ' '{print $2}' | awk -F'.' '{print $2}')
resource_names=$(echo "$resource_entries" | awk -F'# ' '{print $2}' | awk '{print substr($0, index($0,$3))}')

# Extract a short summary of what's happening (using the first hashtag)
summaries=$(echo "$relevant_section" | awk -F'# ' 'NF>1{print $2}' | awk -F' will be ' '{print $1}')

# Display the summarized output in a table
echo -e "Operation\tResource Type\tResource Name\tResource ID\tSummary"
paste <(echo "$operations") <(echo "$resource_types") <(echo "$resource_names") <(echo "$resource_ids") <(echo "$summaries") | column -t -s $'\t'
