/*
----------------------------------------------------------------
Par: Alain Laventure
Creer le: 2026-04-03

Nom du fichier: .bicep

Description de ce que fait ce template
Ce template Bicep définit un tableau de noms de groupes de ressources et 
le parcourt entièrement à l’aide d’une boucle for qui fournit :

la valeur courante du tableau (rg, le nom du resource group)
sa position dans le tableau (i, l’index)

Pour chaque nom de groupe de ressources, le template construit un objet contenant :

le nom du groupe de ressources (name)
un index numérique (index) correspondant à sa position dans le tableau

Tous les objets générés sont regroupés dans un tableau de sortie.
----------------------------------------------------------------
*/


param rgNames array = [
  'rg01'
  'rg02'
  'rg03'
]

/*

ou bien 

param rgNames array = ['rg01', 'rg02', rg03']
*/

output result array = [
  for (rg, i) in rgNames: {
    name: rg
    index: i
  }
]

/*
Name             Type                       Value
===============  =========================  ==========
result           Array                      [{"name":"rg01","index":0},{"name":"rg02","index":1},{"name":"rg03","index":2}]
*/
