targetScope = 'subscription'

param rgNames array = [
  'rg'
  'rg'
  'rg'
]


resource sta 'Microsoft.Resources/resourceGroups@2022-09-01' = [for (rg, i) in rgNames: {
    name: '${rg}-${i}'//concaténation du nom de la resource group et de son index dans le tableau
    location: 'eastus'  
  }]


  /*

  Check le nom des ressources groups `rg-0`, `rg-1` et `rg-2` ont été créés dans le portail Azure.
Name             Type                       Value
===============  =========================  ==========
rgNames          Array                      ["rg01","rg02","rg03"]
  
  */
