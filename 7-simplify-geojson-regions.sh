#!/bin/bash

input_dir="geojson-regions"
simplify_tolerance=0.001  # Adjust the simplification tolerance as needed
merge_distance=1000  # Merging distance in meters (1 km)

# Function to simplify and merge geojson
simplify_geojson() {
    local input_file="$1"
    local output_file="$2"
    echo "Simplifying file - $input_file"
    ogr2ogr -f "GeoJSON" \
      -dialect sqlite \
      -sql "SELECT ST_SimplifyPreserveTopology(ST_Union(ST_Buffer(geometry, $merge_distance)), $simplify_tolerance) AS geometry FROM FORMATION_VEGETALE" \
      -nln FORMATION_VEGETALE \
      -t_srs "EPSG:4326" \
      "$output_file" "$input_file"
}

# Recursively find and process all files ending with "_from10.geojson"
find "$input_dir" -type f -name "*_from10.geojson" | while read -r input_file; do
    base_name=$(basename "$input_file" "_from10.geojson")
    output_file="${input_file%/*}/${base_name}_to11.geojson"
    simplify_geojson "$input_file" "$output_file"
done

echo "Complete."
