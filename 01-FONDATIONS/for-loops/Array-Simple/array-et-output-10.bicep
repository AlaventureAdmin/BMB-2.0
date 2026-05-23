
/*
----------------------------------------------------------------
Par: Alain Laventure
Creer le: 2026-04-29
 

Description (Output):
L’output `result` est un tableau construit dynamiquement à partir du
paramètre `locations`. À l’aide d’une boucle `for`, Bicep parcourt chaque
élément du tableau `locations` et génère un nouvel objet contenant la
propriété `location`.

Lors de l’exécution du déploiement, cet output permet de retourner une
vue transformée des données d’entrée. Il est évalué côté ARM au moment
du déploiement et peut être consommé par PowerShell, Azure CLI ou un
autre template Bicep parent pour des traitements ou validations
supplémentaires.
----------------------------------------------------------------
*/


param locations array = [
  'eastus'
  'westus'
]

output result array = [ 
  for loc in locations: {
    location: loc 
  }
]

/*

Outputs  : 
Name             Type                       Value
===============  =========================  ==========
result           Array                      ["eastus","westus"]



$timestamp = Get-Date -Format "yyyy-MM-dd_HH_mm"
# Lance le déploiement
New-AzResourceGroupDeployment `
  -Name deploy_$Timestamp `
  -ResourceGroupName "rg-bicep06" `
  -TemplateFile '.\tempo.bicep' `
  -Mode Incremental `
  -Verbose

*/
