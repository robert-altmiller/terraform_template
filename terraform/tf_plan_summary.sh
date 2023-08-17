#!/bin/bash

# Run terraform plan and save the output to a file
terraform plan | python3 ./python/summarize_text.py