/*
----------------------------------------------------------------
Par: Alain Laventure
Créé le: 2026-04-03

Nom du fichier: Mod-Create-VM-With-PublicIP-or-whitout-PublicIP.bicep

Description:
Template Bicep déployé au scope Subscription permettant de créer dynamiquement plusieurs Resource Groups à partir d’une liste définie dans le code.
Il utilise une boucle pour automatiser la création des groupes de ressources et expose un output afin de valider les noms des RG créés.
Idéal pour les scénarios d’initialisation d’environnement ou de tests de déploiement multi‑Resource Groups.

----------------------------------------------------------------
*/

targetScope = 'subscription'

//liste des noms de RG à créer
var rgNames = [
  'rg-01'
  'rg-02'
 
]

//Loop pour créer les RG
resource rg 'Microsoft.Resources/resourceGroups@2025-04-01' = [
  for i in range(0,length(rgNames)): {   //Fonction Bicep qui retourne le nombre d’éléments dans l’array :
    name: rgNames[i]
    location: 'eastus'
  }
]

//output pour voir les noms des RG créés
output result array = [for rg in rgNames: {
  name: rg
  }]

/*
Outputs                 : 
Name             Type                       Value
===============  =========================  ==========
result           Array
[{"name":"rg-01"},{"name":"rg-02"}]
]
*/
