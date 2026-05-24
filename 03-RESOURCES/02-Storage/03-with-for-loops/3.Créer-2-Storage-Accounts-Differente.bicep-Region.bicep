/*
----------------------------------------------------------------
Par: Alain Laventure
Creer le: 2026-04-19

Description: 

----------------------------------------------------------------
*/



var storages = [
  { name: 'solulan01', location: 'canadacentral' }
  { name: 'solulan02', location: 'canadaeast' }
]
resource sa 'Microsoft.Storage/storageAccounts@2023-01-01' = [
  for st in storages: {
    name: st.name
    location: st.location
    kind: 'StorageV2'
    sku: {
      name: 'Standard_LRS'
    }
  }
]

/*
Résultat
✅ 2 storage accounts dans 2 régions différentes

*/
