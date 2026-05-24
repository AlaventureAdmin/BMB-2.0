/*
Transforme une liste de régions en une liste d’objets contenant la propriété location.

*/

param locations array = [
  'eastus'
  'westus'
]



output result1 array = [ // Output will be [{"location":"eastus"},{"location":"westus"}]
  for loc in locations: { 
    location:loc 
  }
]


output result2 array = [ // Output will be [{"location":"eastus"},{"location":"westus"}]
  for loc in locations: loc 
  ]


  /*
Outputs                 : 
Name             Type                       Value
===============  =========================  ==========
  result1          Array                      [{"location":"eastus"},{"location":"westus"}]
  result2          Array                      ["eastus","westus"]
   */
