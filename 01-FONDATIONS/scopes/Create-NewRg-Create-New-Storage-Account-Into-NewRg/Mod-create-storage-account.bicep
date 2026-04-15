/*
----------------------------------------------------------------
Par: Alain Laventure
Creer le: 2026-04-03
Nom du fichier: Mod-create-storage-account.bicep
#8
This is a module that is called from the main.bicep file to create a storage account
in a new resource group that is also created in the main.bicep file. 

It defines the creation of a new storage account.

No values are declared within this template

all parameters are passed from 3a create ResourceGroup.bicep 

*/


//param are empty because they are received their value from the main.bicep 
param storageAccountName string

param storageAccountLocation string

//Create the storage account 
resource storageAccount 'Microsoft.Storage/storageAccounts@2024-01-01' = {
  name: storageAccountName

  location: storageAccountLocation
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}


