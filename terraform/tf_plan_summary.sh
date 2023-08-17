#!/bin/bash

plan_output=$(terraform plan)

# Extract the actions and resources
actions=$(echo "$plan_output" | grep -E '# .+ will be' | awk -F'# ' '{print $2}' | awk -F' ' '{print $1}' | sed 's/module.\+\.//')
resources=$(echo "$plan_output" | grep -E '# .+ will be' | awk -F'# ' '{print $2}' | awk -F' ' '{print $2}' | sed 's/module.\+\.//')

# Display the summarized output in a table
echo -e "Operation\tResource Type\tResource Name"
paste <(echo "$actions") <(echo "$resources") | column -t