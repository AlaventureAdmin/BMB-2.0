
/*
  Déploiement au niveau subscription :
  - Création d’un nouveau Resource Group
  - Déploiement d’un Storage Account dans ce RG via un module Bicep
*/




targetScope = 'subscription' // change the scope to subscription to be able to create a new resource Group 
// By default the targetscope is at resourceGroup 

param newResourceGroupName string = 'RG5' //The new resource Group Here RG5

param resourceGroupLocation string = 'eastus' //the location of the new RG5 Here eastus

param storageAccountName string = 'solulansta' //We are deploying a new storage account within a newly created resource group called RG5.

param storageAccountLocation string = 'eastus' //The location of the new storage account 

//create the new RG RG5 in the location eastus
resource newRgName 'Microsoft.Resources/resourceGroups@2024-11-01' = {
  name: newResourceGroupName //The name of the new RG here RG5 
  location: resourceGroupLocation //The location of the new resource Grup here eastus
}

//we will create the storage Account  
module storageModule 'create-storage-account.bicep' = {
  name: 'storageDeployment'
  
  scope: newRgName //Deploy the storage account created in the module in the newRG, here RG5 
  params: {
    storageAccountName: storageAccountName //the storageAcccountName //create a new storage Account in the new RG , RG5
    storageAccountLocation: storageAccountLocation //the location of the new storage account 
  }
}



/*
  $timestamp = Get-Date -Format "yyyy-MM-dd_HH_mm"
# Lance le déploiement
  New-AzsubscriptionDeployment `
  -location 'eastus' `
  -Name deploy_$Timestamp `
  -TemplateFile .\main.bicep ``
  -verbose 

*/
