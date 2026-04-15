/*
----------------------------------------------------------------
Par: Alain Laventure
Creer le: 2026-04-03
Nom du fichier: main-create-VM.bicep
#9
Description: Template Bicep de base pour la creation de ressources Azure.

----------------------------------------------------------------

In this template we will create a new ResourceGorup name RG5
After we will create a new VM the new Resource Group RG5
We will use a module to create the VM 

*/


// Paramters sections ==============================================================

targetScope = 'subscription' // change the scope to suncription to be able to create a new resource Group 
// By default the targetscope is at resourceGroup 

param resourceGroupName string = 'RG5' //The new resource Group

param resourceGroupLocation string = 'eastus' //the location of the new RG

@description('ask the AdminUserName')
param adminUsername string

@description('ask the AdminUserPassword in secure mode ')
@secure()
param adminPassword string

@description('Name of the NSG')
param nsgName string = 'nsg'
///param storageLocation string = 'eastus' //The location of the new storage account 

@description('Array of subnet configurations including name and address prefix')
param subnets array = [
  {
    subnetName: 'api'
    subnetPrefix: '10.144.0.0/24'
    vmName: 'MTLDC01' // <------------------------- Add the name of the BM 
  }
  {
    subnetName: 'worker'
    subnetPrefix: '10.144.1.0/24'
    vmName: 'MTLSQL01'
  }
  {
    subnetName: 'dev'
    subnetPrefix: '10.144.2.0/24'
    vmName: 'MTLFS01'
  }
]


//=============================================================================

//create the new RG RG5 in the location eastus
resource newRG 'Microsoft.Resources/resourceGroups@2024-11-01' = {
  name: resourceGroupName //The name of the new RG here RG5 
  location: resourceGroupLocation //The location of the new resource Grup here solulan09
}

//we will create the storage Account  
module VMModule 'Mod-Create-Vm.bicep' = { // we will call the module to create the VM in the new RG RG5
  name: 'VMDeployment' // the name of the module deployment, you can choose any name you want#
  scope: newRG //Deploy the storage account created in the module in the newRG, here RG5 

  params: {
    nsgName: nsgName
    adminPassword: adminPassword
    adminUsername: adminUsername
    subnets: subnets // we will pass the array of subnets to the module to create the VM in each subnet
    rgLocation: resourceGroupLocation // we will pass the location of the resource group to the module
  //gauche viens main et droite viens du module
  }
}


