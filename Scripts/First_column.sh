#!/bin/bash

for file in /path/to/output_file.out; do
    # Extract the first column and save it with the new filename
    awk '{print $1}' "$file" > "filename_Column1.txt"
done


