/*
----------------------------------------------------------------
Par: Alain Laventure
Creer le: 2026-04-03

Nom du fichier: .bicep

Description de ce que fait ce template
Ce template Bicep est conçu pour être déployé au niveau de l’abonnement 
Azure et a pour objectif de créer plusieurs groupes de ressources automatiquement 
à partir d’un tableau de noms.
Le template :

définit un tableau de noms de resource groups
parcourt ce tableau à l’aide d’une boucle for
crée un groupe de ressources Azure par élément du tableau
assigne à chaque groupe de ressources :

un nom basé sur la valeur du tableau
une région Azure fixe (eastus)
----------------------------------------------------------------
*/

targetScope = 'subscription'

param rgNames array = [
  'rg01'
  'rg02'
  'rg03'
]

/*

ou bien 

param rgNames array = ['rg01', 'rg02', rg03']
*/

resource sta 'Microsoft.Resources/resourceGroups@2022-09-01' = [for rgName in rgNames: {
  name: rgName
  location: 'eastus'
  
  }]


  /*
Name             Type                       Value
===============  =========================  ==========
rgNames          Array                      ["rg01","rg02","rg03"]
  */
