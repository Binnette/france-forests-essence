#!/bin/bash

# Directory to search
dir="tmp"
outdir="gpkg"
# Path to the regions YAML file
regions_file="assets/regions.yml"

# Check if the regions file exists
if [ ! -f "$regions_file" ]; then
    echo "Regions file not found: $regions_file"
    exit 1
fi

# Find all .shp files in the directory and its subdirectories
shp_files=$(find "$dir" -type f -name "*.shp")

# Check if any .shp files were found
if [ -z "$shp_files" ]; then
    echo "No .shp files found in $dir"
    exit 1
fi

# Parse the regions YAML file and process each region
while IFS= read -r line; do
    # Check for region name
    if [[ "$line" =~ ^[A-Za-z] ]]; then
        region_name=$(echo "$line" | sed 's/://g')
        echo "#### Processing region: $region_name"
        output="${outdir}/${region_name}.gpkg"
        init=0
    else
        dept=$(echo "$line" | awk '{print $2}')
        # Filter shp_files to include only those containing the department code
        dept_shp_files=$(echo "$shp_files" | grep "$dept")
        
        # Check if any shp files were found for the department
        if [ -z "$dept_shp_files" ]; then
            echo "No shp files found for department $dept in $dir"
            continue
        fi
        
        # Initialize the output GeoPackage file with the first shapefile
        if [ $init -eq 0 ]; then
            echo "Initializing $output with $dept"
            ogr2ogr -f GPKG "$output" "$dept_shp_files"
            init=1
        else 
            echo "Appending $dept to $output"
            ogr2ogr -f GPKG -append -update "$output" "$dept_shp_files"
        fi
    fi
done < "$regions_file"

# Check if the merge was successful
if [ $? -eq 0 ]; then
    echo "All shapefiles merged successfully"
else
    echo "An error occurred while merging the shapefiles"
fi
