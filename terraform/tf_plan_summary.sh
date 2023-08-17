#!/bin/bash

# Run terraform plan and save the output to a file
terraform plan --auto-approve | python3 ./python/summarize_text.py