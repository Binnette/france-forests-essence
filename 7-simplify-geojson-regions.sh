#!/bin/bash

input_dir="geojson-regions"
simplify_tolerance=1  # Adjust the simplification tolerance as needed
merge_distance=0,1  # Merging distance in km

# Function to clean, simplify, and merge geojson
simplify_geojson() {
    local input_file="$1"
    local output_file="$2"
    echo "Simplifying file - $input_file"

    # Ensure the temporary file is unique and clean it up if it exists
    tmp_file=$(mktemp --suffix=".geojson")
    rm -f "$tmp_file"

    # Clean the geometry
    ogr2ogr -f "GeoJSON" \
      -dialect sqlite \
      -sql "SELECT ST_MakeValid(geometry) AS geometry FROM FORMATION_VEGETALE" \
      "$tmp_file" "$input_file"

    # Simplify and merge features
    ogr2ogr -f "GeoJSON" \
      -dialect sqlite \
      -sql "SELECT ST_SimplifyPreserveTopology(ST_Union(ST_Buffer(geometry, $merge_distance)), $simplify_tolerance) AS geometry FROM FORMATION_VEGETALE" \
      -nln FORMATION_VEGETALE \
      -t_srs "EPSG:4326" \
      "$output_file" "$tmp_file"

    # Clean up temporary file
    rm -f "$tmp_file"
}

# Recursively find and process all files ending with "_from10.geojson"
find "$input_dir" -type f -name "*_from10.geojson" | while read -r input_file; do
    base_name=$(basename "$input_file" "_from10.geojson")
    output_file="${input_file%/*}/${base_name}_to11.geojson"
    simplify_geojson "$input_file" "$output_file"
done

echo "Complete."
