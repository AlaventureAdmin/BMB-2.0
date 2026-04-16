/*
----------------------------------------------------------------
Par: Alain Laventure
Creer le: 2026-04-03

Nom du fichier:
Loop-Index-Range-without-parameter.bicep

Description:
Ce template démontre l’utilisation d’une boucle `for` en Bicep pour automatiser
la création de plusieurs comptes de stockage à partir d’une seule définition
de ressource.

La fonction `range()` est utilisée pour générer une série de valeurs numériques.
À chaque itération, l’index de la boucle est stocké dans une variable (`i`) et
est ajouté au nom de base du storage account afin de garantir des noms uniques.

Cette approche permet d’éviter la duplication de code, de réduire les erreurs
manuelles et de faciliter le déploiement de plusieurs ressources identiques
en une seule exécution du template.

----------------------------------------------------------------
*/


param location string = resourceGroup().location // location de la ressource
param storageAccountName string = 'solulanstorage' //nom du storage account


resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = [
  for i in range(1,2): {
    // creation de plusieurs storage account avec index
    name: '${storageAccountName}${i}' // L’index i sert ici à rendre chaque storage account unique :
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


// le 1er chiffre est la valeur de départ
// le 2e chiffre est le nombre d’itérations

//pour range(1,2) output est solulanstorage1, solulanstorage2
//pour range(1,4) output est solulanstorage1, solulanstorage2, solulanstorage3, solulanstorage4
//pour range (2,4) output est solulanstorage2, solulanstorage3, solulanstorage4, solulanstorage5
//pour range (2,5) output est solulanstorage2, solulanstorage3, solulanstorage4, solulanstorage5, solulanstorage6

