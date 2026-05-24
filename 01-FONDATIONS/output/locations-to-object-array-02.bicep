
/*
----------------------------------------------------------------
Par: Alain Laventure
Creer le: 2026-04-29
 

Description (Output):
Transforme une liste de chaînes locations en une liste d’objets { location: <valeur> }


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
