param locations array = [
  'eastus'
  'westus'
]

output result array = [
  for loc in locations: {
    location: loc
  }
]

/*
Name             Type                       Value
===============  =========================  ==========
result           Array                      [{"location":"eastus"},{"location":"westus"}] 

*/
