#!/bin/bash

# Define paths
essences_file="assets/essences.txt"
input_dir="gpkg-regions"
output_dir="geojson-regions"

# Create the output directory if it doesn't exist
mkdir -p "$output_dir"

# Read each .gpkg file in the input directory
for gpkg in "$input_dir"/*.gpkg; do
    # Get the region name from the .gpkg filename
    region_name=$(basename "$gpkg" .gpkg)
    
    # Create a directory for the region in the output directory
    region_output_dir="$output_dir/$region_name"
    mkdir -p "$region_output_dir"
    
    echo "## Processing region: $region_name"
    
    # Read each line from the essences file and process
    while IFS= read -r essence; do
        echo "Processing ESSENCE: $essence"
        essence=$(echo "$essence" | sed "s/'/''/g")
        output_file="$region_output_dir/${essence}.geojson"
        ogr2ogr -f "GeoJSON" -t_srs "EPSG:4326" -simplify 10 -lco COORDINATE_PRECISION=4 -where "ESSENCE='$essence'" "$output_file" "$gpkg"
    done < "$essences_file"
done

echo "Processing complete."
