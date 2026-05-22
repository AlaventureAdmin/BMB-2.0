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




