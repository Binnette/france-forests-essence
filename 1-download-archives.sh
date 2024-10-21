#!/bin/bash

download_list_path="assets/downloads.txt"
tmp_folder="tmp"

# Create the tmp folder if it doesn't exist
if [ ! -d "$tmp_folder" ]; then
    mkdir -p "$tmp_folder"
fi

# Read URLs from the download list
urls=$(cat "$download_list_path")
downloaded_files=0

# Download each URL if the file doesn't already exist
for url in $urls; do
    filename="$tmp_folder/$(basename "$url")"
    if [ ! -f "$filename" ]; then
        echo "Downloading $url"
        curl -o "$filename" "$url"
        if [ $? -eq 0 ]; then
            downloaded_files=$((downloaded_files + 1))
        else
            echo "Error downloading $url"
        fi
    else
        echo "File $filename already exists, skipping download"
    fi
done

echo "Total URLs: $(wc -l < "$download_list_path")"
echo "Downloaded files: $downloaded_files"
