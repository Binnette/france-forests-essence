# France Forest

## How to use

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
