#!/bin/bash

# Define the directory containing the .7z files
dir="tmp"

# Check if the directory exists
if [ ! -d "$dir" ]; then
    echo "Directory $dir does not exist"
    exit 1
fi

# Find and extract all .7z files in the directory
find "$dir" -name "*.7z" | while read -r archive; do
    echo "Extracting $archive"
    7z x "$archive" -o"${archive%*.7z}"
done

echo "Extraction complete."
