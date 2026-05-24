/*
----------------------------------------------------------------
Par: Alain Laventure
Creer le: 2026-04-19


Description: Créer 3 storage accounts et afficher l’index.

----------------------------------------------------------------
*/

var storageNames = [
  'solulanv01'
  'solulanv02'
  'solulanv03'
]
resource sa 'Microsoft.Storage/storageAccounts@2023-01-01' = [
  for (name, index) in storageNames: {
    name: '${name}${index}'
    location: resourceGroup().location
    kind: 'StorageV2'
    sku: {
      name: 'Standard_LRS'
    }
  }
]

/*

Explication (ligne par ligne)
•	storageAccounts = [
→ on dit à Bicep : je vais créer plusieurs resources
•	for name in storageNames
→ une resource par élément
•	name: name
→ le nom de la resource = valeur de l’array
Résultat

✅ 3 storage accounts créés :
•	solulanv01
•	solulanv02
•	solulanv03


*/
