targetScope = 'subscription'

param rgNames array = [
  'rg01'
  'rg02'
  'rg03'
]

/*

ou bien 

param rgNames array = ['rg01', 'rg02', rg03']
*/

resource sta 'Microsoft.Resources/resourceGroups@2022-09-01' = [for rgName in rgNames: {
  name: rgName
  location: 'eastus'
  
  }]


  /*
Name             Type                       Value
===============  =========================  ==========
rgNames          Array                      ["rg01","rg02","rg03"]
  */
