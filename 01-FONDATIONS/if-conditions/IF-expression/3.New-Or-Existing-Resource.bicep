/*
----------------------------------------------------------------
Par: Alain Laventure
Creer le: 2026-04-03


Description: 
You can use conditional deployment to create a new resource or use an existing one. 

The following example shows how to deploy a new storage account or use an existing 
storage account.

When the parameter newOrExisting is set to new, the condition evaluates to true. 
The storage account is deployed. Otherwise, the existing storage account is used.
----------------------------------------------------------------
*/

param storageAccountName string ='solsta'
param location string = resourceGroup().location

@allowed([
  'new'
  'existing'
])
param newOrExisting string = 'new'

resource saNew 'Microsoft.Storage/storageAccounts@2025-06-01' = if (newOrExisting == 'new') {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

resource saExisting 'Microsoft.Storage/storageAccounts@2025-06-01' existing = if (newOrExisting == 'existing') {
  name: storageAccountName
}

output storageAccountId string = ((newOrExisting == 'new') ? saNew.id : saExisting.id)
