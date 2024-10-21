#!/bin/bash

# Define paths
essences_file="assets/essences.txt"
input_gpkg="./gpkg-france/france.gpkg"
output_dir="./geojson-france"

# Create the output directory if it doesn't exist
mkdir -p "$output_dir"

# Read each line from essences_file and process
while IFS= read -r essence
do
    echo "Processing ESSENCE: $essence"
    output_file="$output_dir/${essence}.geojson"
    essence=$(echo "$essence" | sed "s/'/''/g")
    ogr2ogr -f "GeoJSON" -t_srs "EPSG:4326" -simplify 10 -lco COORDINATE_PRECISION=4 -select ESSENCE -where "ESSENCE='$essence'" "$output_file" "$input_gpkg"
done < "$essences_file"

echo "Processing complete."
