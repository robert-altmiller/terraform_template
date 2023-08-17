#!/bin/bash

# Run terraform plan and save the output to a file
terraform plan > plan_output.txt

# Initialize an empty array to hold the summary lines
declare -a summary_lines

# Read the plan output line by line and extract the relevant information
while IFS= read -r line; do
  if [[ $line == "# "* ]]; then
    resource_type=$(echo "$line" | awk '{print $2}' | cut -d'.' -f2)
    resource_name=$(echo "$line" | awk '{print $2}' | cut -d'.' -f3)
    operation=$(echo "$line" | awk '{print $3}' | awk -F'[' '{print $1}' | tr -d ' ')
    summary=$(echo "$line" | cut -d'#' -f2)
    id_line=$(grep -A1 "id =" plan_output.txt | tail -n1)
    resource_id=$(echo "$id_line" | awk -F'= ' '{print $2}' | tr -d ' ' | tr -d '"')
    summary_line="$operation $resource_type $resource_name $resource_id \"$summary\""
    summary_lines+=("$summary_line")
  fi
done < plan_output.txt

# Output the table with headers
echo -e "Operation\tResource Type\tResource Name\tResource ID\tSummary"
for line in "${summary_lines[@]}"; do
  echo -e "$line"
done

# Remove the temporary plan output file
rm plan_output.txt