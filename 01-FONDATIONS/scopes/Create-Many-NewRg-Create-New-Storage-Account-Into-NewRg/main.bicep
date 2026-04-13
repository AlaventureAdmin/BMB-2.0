/*

----------------------------------------------------------------
Par: Alain Laventure
Creer le: 2026-04-08
Nom du fichier: main.bicep

Description:
Ce template Bicep déploie dynamiquement plusieurs Resource Groups à partir d’un tableau de noms.
Pour chaque Resource Group créé, un module est appelé afin de déployer un Storage Account.
Le déploiement est effectué au niveau de l’abonnement (subscription scope) et garantit que les
Resource Groups existent avant la création des Storage Accounts grâce à l’utilisation de dependsOn.

----------------------------------------------------------------
*/


targetScope = 'subscription'

@description('List of the name of the reosurce group to be created')
param resourceGroupNames array = [
  'rg1'
  'rg2'
  'rg3'
  
  ]

@description('Location of the New resource Group')
param resourceGroupLocationName string = 'eastus'

// Create the new resourceGroup
resource resourceGroups 'Microsoft.Resources/resourceGroups@2024-11-01' = [for rgName in resourceGroupNames: {
  name: rgName
  location: resourceGroupLocationName 
}]


// Deploy module that will create many storage account in each new resourcegroup

module storageDeployment 'Mod-Create-Storage-Account-into-NewRg.bicep' = [for (rgName, i) in resourceGroupNames: {
  name: 'storageDeploy-${rgName}'
  scope: resourceGroup(rgName) //Le scope est le RG, car le storage account doit etre creer dans le RG
 
  //Doit mettre depensdson: , car le template doit etre certain que le RG ont bien ete creer avant de creer le storage Account 
  //Sans cela il plusieurs fois que cela donne une erreur car il essais de creer le storageaccount avant quele RG soit creer 
 
  dependsOn: [ 
  resourceGroups[i]
  ]

   // le parameter de gauche est defenie dans le module et le parameter de droite est definie dans le template main.bicep 
  params: {
    storageAccountName: 'solulan${rgName}' 
    location: resourceGroupLocationName  
  }
}]

// Resultat de ce template
// cela va creer RG qui sont definie dans le array RG1, RG2 , et dans chaque RG il y a un storage account 
// qui sera creer avec le nom solulanRG1, solulanRG2


/*
$timestamp = Get-Date -Format "yyyy-MM-dd_HH_mm"
# Lance le déploiement
New-AzsubscriptionDeployment `
  -location 'eastus' `
  -Name deploy_$Timestamp `
  -TemplateFile .\main.bicep `
  -verbose 
*/
