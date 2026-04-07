/*
---------------------------------------------------------------
Par Alain Laventure
Date: 2024-06-17
Nom du Template : If-dev-or-prod.bicep
---------------------------------------------------------------

IF / ELSE (Conditional logic)

We want to configure the SKU of the Storage Account:
- 'Standard_LRS' for DEV / TEST environments
- 'Standard_GRS' for PROD environments

We test the environmentType parameter:
- If environmentType == 'prod'  -> Standard_GRS
- Otherwise                     -> Standard_LRS

IMPORTANT:
- 'dev' and 'prod' are case sensitive
---------------------------------------------------------------
*/

// Parameters and Variables Definition Section =============================
@allowed(['dev', 'prod']) // The allowed decorator restricts the values of the parameter to 'dev' or 'prod'
@description('Specify the environment type: dev or prod (case-sensitive)')
///param environmentType string = 'prod' // Default value is 'prod', change to 'dev' to test the 'dev' environment type
param environmentType string = 'prod' // Uncomment this line to test the 'dev' environment type


@description('Storage Account name prefix (must be lowercase, 3 to 11 characters)')
@minLength(3)
@maxLength(11)
param storageAccountNamePrefix string = 'solu' 
// Reminder: storage account names must be lowercase
// If the prefix exceeds 11 characters, a validation error will occur

@description('Location where resources will be deployed')
param location string = resourceGroup().location
// resourceGroup().location returns the location of the current resource group

/*
More information about 
var storageAccountSku = environmentType == 'prod'
  ? 'Standard_GRS' 
  : 'Standard_LRS'

var storageAccountSku = environmentType == 'dev'
? condition if valueIfTrue : valueIfFalse
? 'Standard_GRS' : 'Standard_LRS'
*/

@description('Storage Account SKU based on environment type')
var storageAccountSku = environmentType == 'prod'
  ? 'Standard_GRS' // If environmentType is 'prod', use 'Standard_GRS' (true)
  : 'Standard_LRS' // If environmentType is 'dev', use 'Standard_LRS' (false)

@description('Storage Account kind')
var kindName = 'StorageV2'

// =====================================================================

// Merge the prefix with a unique string based on the resource group ID
var storageAccountName = '${storageAccountNamePrefix}${uniqueString(resourceGroup().id)}' 
// The uniqueString function generates a unique string based on the input, 
//ensuring that the storage account name is unique within the resource group
// Example result: solulanx9f3k2a1bq

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageAccountName
  location: location
  sku: {
    // Uses the storageAccountSku variable
    // dev  -> Standard_LRS
    // prod -> Standard_GRS
    name: storageAccountSku 
  }
  kind: kindName
}

output SKUName string = storageAccountSku
output storageAccountName  string =storageAccountName


