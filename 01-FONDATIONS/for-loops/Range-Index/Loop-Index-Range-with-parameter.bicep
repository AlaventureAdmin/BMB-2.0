/*
----------------------------------------------------------------
Par: Alain Laventure
Creer le: 2026-04-03

Nom du fichier:
Loop-Index-Range-with-parameter.bicep

Description:
Ce template utilise une boucle `for` avec la fonction `range()` pour créer
dynamiquement plusieurs comptes de stockage à partir d’un nombre défini
par le paramètre `storageCount`.

L’index de la boucle est utilisé pour générer des noms uniques pour chaque
storage account. Un `output` est également généré afin de retourner la liste
des noms des comptes de stockage créés.

----------------------------------------------------------------
*/

param location string = resourceGroup().location // location de la ressource
param storageAccountName string = 'solulanstorage' //nom du storage account
param storageCount int = 3 // nombre de storage account a creer

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = [
  for i in range(0, storageCount): {
    // creation de plusieurs storage account avec index
    name: '${storageAccountName}${i+1}' // nom du storage account avec index (ajout de 1 pour commencer a 1 au lieu de 0)
    location: location // location de la ressource
    sku: {
      name: 'Standard_LRS' // SKU du storage account
    }
    kind: 'StorageV2' // type de storage account
    properties: {
      supportsHttpsTrafficOnly: true  // securite: n`accepte que le traffic https
    }
  }
]

// output des ids des storage account crees
output storageAccountIds array = [ 
  for i in range(0, storageCount): { 
    name: storageAccount[i].name // nom du storage account
  }
]
