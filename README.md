# France Forest

Data BD Foret V2: https://geoservices.ign.fr/bdforet

## How to use

### View the maps by Essence

| Essence | Map |
| ------- | --- |
| Châtaignier | [🗺](https://umap.openstreetmap.fr/en/map/bd-foret-v2-chataignier_1129508) |
| Chênes décidus | [🗺](https://umap.openstreetmap.fr/en/map/bd-foret-v2-chenes-decidus_1129746) |
| Chênes sempervirents | [🗺](https://umap.openstreetmap.fr/en/map/bd-foret-v2-chenes-sempervirents_1129719) |
| Conifères | [🗺](https://umap.openstreetmap.fr/en/map/bd-foret-v2-coniferes_1131673) |
| Douglas | [🗺](https://umap.openstreetmap.fr/en/map/bd-foret-v2-douglas_1129720) |
| Feuillus | ⚠️[🗺](https://umap.openstreetmap.fr/en/map/bd-foret-v2-feuillus_1131674) |
| Hêtre | [🗺](https://umap.openstreetmap.fr/en/map/bd-foret-v2-hetre_1129721) |
| Mélèze | [🗺](https://umap.openstreetmap.fr/en/map/bd-foret-v2-meleze_1129542) |
| Mixte | - |
| NC | - |
| NR | - |
| Peuplier | [🗺](https://umap.openstreetmap.fr/en/map/bd-foret-v2-peuplier_1129724) |
| Pin à crochets, pin cembro | [🗺](https://umap.openstreetmap.fr/en/map/bd-foret-v2_1129727) |
| Pin autre | [🗺](https://umap.openstreetmap.fr/en/map/bd-foret-v2-pin-autre_1129731) |
| Pin d'Alep | [🗺](https://umap.openstreetmap.fr/en/map/bd-foret-v2-pin-dalep_1129733) |
| Pin laricio, pin noir | [🗺](https://umap.openstreetmap.fr/en/map/bd-foret-v2-pin-laricio-pin-noir_1129734) |
| Pin maritime | [🗺](https://umap.openstreetmap.fr/en/map/bd-foret-v2-pin-maritime_1129736) |
| Pin sylvestre | [🗺](https://umap.openstreetmap.fr/en/map/bd-foret-v2-pin-sylvestre_1131707) |
| Pins mélangés | [🗺](https://umap.openstreetmap.fr/en/map/bd-foret-v2-pins-melanges_1129738) |
| Robinier | [🗺](https://umap.openstreetmap.fr/en/map/bd-foret-v2-robinier_1129742) |
| Sapin, épicéa | [🗺](https://umap.openstreetmap.fr/en/map/bd-foret-v2-sapin-epicea_1131709) |

## How to use scripts

Basically, you don't need to run scripts, just use the geosjon files, see section `How to use`.

1. Open https://geoservices.ign.fr/bdforet
2. Run this JS in console and save the file in `assets/downloads.txt`:
````js
// Get all <a> elements containing "BDFORET_2-0" in their href
var links = document.querySelectorAll('a[href*="BDFORET_2-0"]');
// Extract the URLs and keep only unique ones
var urls = Array.from(new Set(Array.from(links).map(link => link.href)));
// Create a Blob from the URLs and make it downloadable
var blob = new Blob([urls.join('\n')], { type: 'text/plain' });
var url = URL.createObjectURL(blob);
var a = document.createElement('a');
a.href = url;
a.download = 'downloads.txt';
document.body.appendChild(a);
a.click();
document.body.removeChild(a);
URL.revokeObjectURL(url);
````
3. Then run all script from 1 to 8.

## Distincts "ESSENCE"

- Châtaignier
- Chênes décidus
- Chênes sempervirents
- Conifères
- Douglas
- Feuillus
- Hêtre
- Mélèze
- Mixte
- NC
- NR
- Peuplier
- Pin à crochets, pin cembro
- Pin autre
- Pin d'Alep
- Pin laricio, pin noir
- Pin maritime
- Pin sylvestre
- Pins mélangés
- Robinier
- Sapin, épicéa
