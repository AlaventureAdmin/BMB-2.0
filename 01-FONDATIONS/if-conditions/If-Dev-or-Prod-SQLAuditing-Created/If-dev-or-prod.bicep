/*

Par: Alain Laventure
Creer le: 2026-04-08

Nom du fichier: If-dev-or-prod.bicep
Description: 
In this exercise, you'll create an Azure SQL logical server and a database. 
You'll then add auditing settings to ensure that auditing is enabled,
 but you want it enabled only when you're deploying to a production environment.
  For auditing purposes, you need to have a storage account, which you'll also 
  deploy only when you're deploying resources to a production environment.

During the process, you'll:

-Create a Bicep file that defines a logical server with a database.
-Add a storage account and SQL auditing settings, each of which is deployed with a condition.
-Set up an infrastructure for your development environment and then verify the result.
-Redeploy your infrastructure against your production environment and then look at the changes.

Ce template demande 3 parameters

Location
Login Name du serveur SQL 
Le mot de passe pour le serveur SQL 
Important le mot de passe doit contenir des minuscule, majsucule, ,lettre, chiffre, caractere speciaux 

Note: Le deploiment de l'environnement de prodction prend environs 20 minutes 
*/

@description('The location where the resources will be deployed.')
param location string

@description('The administrator login username for the SQL server.')
param sqlServerAdministratorLogin string


//Le mot de passe pour le serveur SQL 
//Important le mot de passe doit contenir des minuscule, majuscule, ,lettre, chiffre, caractere speciaux 

@secure() // This is a secure parameter, which means that its value will be encrypted and not displayed in plain text in deployment logs or outputs.
@description('The administrator login password for the SQL server.')
param sqlServerAdministratorLoginPassword string

@description('The name and tier of the SQL database SKU.')
param sqlDatabaseSku object = { //This is an object parameter that contains the name and tier of the SQL database SKU. The default value is set to an object with the name 'Standard' and the tier 'Standard'.
  name: 'Standard'
  tier: 'Standard'
}


@description('The name of the audit storage account SKU.')
param auditStorageAccountSkuName string = 'Standard_LRS'

var sqlServerName = 'Sol${location}${uniqueString(resourceGroup().id )}'
var sqlDatabaseName = 'Solulan'


@description('The name of the environment. This must be Development or Production.')
@allowed([
  'Development'
  'Production'
])

//Select this parameter To deploy Production 
param environmentName string = 'Production'  

//Select this parameter To deploy Development
///param environmentName string = 'Development' 

//if environementName is Production the condition is true so,
//auditingEnabled is true 
//if environementName is Development the condition is false so,
//auditingEnabled is false 
var auditingEnabled = environmentName =='Production'

var auditStorageAccountName= take('bearaudit${location}${uniqueString(resourceGroup().id )}',24) //The name of a storage account must be between 3 and 24 characters in length and can contain only lowercase letters and numbers.

//Install SQL Server
resource sqlServer 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: sqlServerName //This is the symbolic name of the SQL Server, which is used to reference this resource in other parts of the Bicep file.
  location: location
  properties: {
    administratorLogin: sqlServerAdministratorLogin
    administratorLoginPassword: sqlServerAdministratorLoginPassword
  }
}

//Install the Database on server SQL
resource sqlDatabase 'Microsoft.Sql/servers/databases@2024-05-01-preview' = {
  parent: sqlServer //this is the symbolic name of the SQL Server
  name: sqlDatabaseName //This is the symbolic name of the SQL Database, which is used to reference this resource in other parts of the Bicep file.
  location: location
 sku:sqlDatabaseSku //This is the SKU of the SQL Database, which specifies the performance level and other characteristics of the database. The value of this property is determined by the sqlDatabaseSku parameter, which is an object that contains the name and tier of the SKU.
}

//If auditingEnabled contain Development the auditingEnabled is false 
//the Storage Account willl not be created

//If auditingEnabled contain Production the auditingEnabled is true 
//the Storage Account will not be created
resource auditStorageAccount 'Microsoft.Storage/storageAccounts@2025-01-01' = if (auditingEnabled) {
  name: auditStorageAccountName //This is the symbolic name of the storage account, which is used to reference this resource in other parts of the Bicep file.
  location: location
  sku: {
    name: auditStorageAccountSkuName //This is the SKU of the storage account, which specifies the performance level and other characteristics of the storage account. The value of this property is determined by the auditStorageAccountSkuName parameter, which is a string that contains the name of the SKU.
  }
  kind: 'StorageV2'  //This is the kind of the storage account, which specifies the type of storage account to create. The value of this property is set to 'StorageV2', which is the latest version of the storage account and supports all features.
}
//If auditingEnabled contain Development the auditingEnabled is false 
//the Audit will not be enable

//If auditingEnabled contain Production the auditingEnabled is true 
//the Audit will be enable 
/*
Notice that the definition includes the same if condition as the storage account. 
Also, the storageEndpoint and storageAccountAccessKey properties use 
the question mark (?) ternary operator to ensure that their values are always valid. 
If you don't do this, Azure Resource Manager evaluates the expression values before it evaluates
 the resource deployment condition and returns an error, because the storage account can't be found.
*/
resource sqlServerAudit  'Microsoft.Sql/servers/auditingSettings@2024-05-01-preview' = if (auditingEnabled) { 
  parent: sqlServer
  name: 'default'
  properties: {
    state:'Enabled'
    
    //The storageEndpoint and storageAccountAccessKey properties use the question mark (?) ternary operator to ensure that
    // their values are always valid.
  
    /*
    storageEndpoint: environmentName =='Production' ? auditStorageAccount.properties.primaryEndpoints.blob: ''
  storageAccountAccessKey: environmentName =='Production' ? auditStorageAccount.listKeys().keys[0].value: ''
*/
}
}

