#!/bin/bash

# Directory to search
dir="tmp"

# Output GeoPackage file
output="./gpkg/france.gpkg"

# Find all shp files in the directory and its subdirectories
shp_files=$(find "$dir" -type f -name "*.shp")

# Check if any shp files were found
if [ -z "$shp_files" ]; then
    echo "No shp files found in $dir"
    exit 1
fi

# Initialize the output GeoPackage file with the first shapefile
first_shp=$(echo "$shp_files" | head -n 1)
ogr2ogr -f GPKG "$output" "$first_shp"

# Append the remaining shapefiles to the output GeoPackage file
for shp in $(echo "$shp_files" | tail -n +2); do
    ogr2ogr -f GPKG -append -update "$output" "$shp"
done

# Check if the merge was successful
if [ $? -eq 0 ]; then
    echo "All shp files merged successfully into $output"
else
    echo "An error occurred while merging the shp files"
fi
