/*

----------------------------------------------------------------
Par: Alain Laventure
Creer le: 2026-04-08

This module called by the main template and create storage account 
in each resource group that is created by the main template

*/

param storageAccountName string
param location string

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
   name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}


