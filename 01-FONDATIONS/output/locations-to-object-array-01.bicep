/* Transforme une liste de chaînes locations en une liste d’objets { location: <valeur> } */

param locations array = [
  'eastus'
  'westus'
]

output result array = [ // Output will be [{"location":"eastus"},{"location":"westus"}]
  for loc in locations: {
    location: loc 
  }
]

/*
Name             Type                       Value
===============  =========================  ==========
result           Array                      [{"location":"eastus"},{"location":"westus"}] 

*/




