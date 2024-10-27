import os
import json
import re

# Define paths
regions_file_path = './assets/regions.txt'
essences_file_path = './assets/essences.txt'
output_dir = './umap'

# Create the output directory if it doesn't exist
os.makedirs(output_dir, exist_ok=True)

# Read the regions and essences from the files
with open(regions_file_path, 'r', encoding='utf-8') as f:
    regions = [line.strip() for line in f]

with open(essences_file_path, 'r', encoding='utf-8') as f:
    essences = [line.strip() for line in f]

# Template for the JSON file
json_template = {
    "type": "umap",
    "geometry": {
        "type": "Point",
        "coordinates": [
            6.94,
            46.92
        ]
    },
    "properties": {
        "name": "",
        "zoom": 6,
        "description": "",
        "limitBounds": {},
        "shortCredit": "https://geoservices.ign.fr/bdforet",
        "zoomControl": True,
        "scrollWheelZoom": True,
        "fullscreenControl": True,
        "permanentCreditBackground": False
    },
    "layers": []
}

# Process each essence
for essence in essences:
    print(f"Processing ESSENCE: {essence}")
    
    # Create a copy of the template
    json_data = json.loads(json.dumps(json_template))  # Deep copy
    
    # Update properties
    json_data['properties']['name'] = f"BD For\u00eat V2 {essence}"
    json_data['properties']['description'] = f"Arbres de type \"{essence}\" extraits de la \"BD For\u00eat\u00ae V2\"\nSource : https://geoservices.ign.fr/bdforet"
    
    # Add layers for each region
    for region in regions:
        region_dir = f"./geojson-regions/{region}"
        if os.path.exists(region_dir):
            for filename in os.listdir(region_dir):
                if filename.startswith(essence) and filename.endswith(".geojson"):
                    arg = filename[len(essence):-8]  # Extract the argument part
                    layer = {
                        "type": "FeatureCollection",
                        "features": [],
                        "_umap_options": {
                            "name": f"{region} - {essence}",
                            "opacity": 0.8,
                            "editMode": "advanced",
                            "browsable": True,
                            "inCaption": True,
                            "remoteData": {
                                "ttl": "86400",
                                "url": f"https://raw.githubusercontent.com/Binnette/france-forests-essence/refs/heads/main/geojson-regions/{region}/{filename}",
                                "format": "geojson"
                            },
                            "description": f"Arbres \"{essence}\" dans la région {region}",
                            "displayOnLoad": True
                        }
                    }
                    if arg.startswith("_from"):
                        number = re.search(r'\d+', arg).group()
                        layer["_umap_options"]["fromZoom"] = int(number)
                    elif arg.startswith("_to"):
                        number = re.search(r'\d+', arg).group()
                        layer["_umap_options"]["toZoom"] = int(number)
                    
                    json_data['layers'].append(layer)
    
    # Save the JSON to a file
    output_file_path = os.path.join(output_dir, f"{essence}.umap")
    with open(output_file_path, 'w', encoding='utf-8') as f:
        json.dump(json_data, f, ensure_ascii=False, indent=2)
    
    print(f"Created file: {output_file_path}")

print("Processing complete.")
