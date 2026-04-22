/*
----------------------------------------------------------------
Par: Alain Laventure
Creer le: 2026-04-03

Description: 

----------------------------------------------------------------
*/

param resourceName string
param location string = resourceGroup().location

// 1. On essaie de référencer la ressource (existing)
resource checkResource 'Microsoft.Storage/storageAccounts@2023-01-01' existing = {
  name: resourceName
}

// 2. Variable pour savoir si elle existe (booléen)
var exists = !empty(checkResource.id)

// 3. Création conditionnelle si 'exists' est faux
resource deployResource 'Microsoft.Storage/storageAccounts@2023-01-01' = if (!exists) {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}
