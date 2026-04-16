/*
----------------------------------------------------------------
Par: Alain Laventure
Creer le: 2026-04-03

Nom du fichier: 
Description: Template Bicep de base pour la creation de ressources Azure.

Ce template Bicep prend un tableau de chaînes de caractères en entrée et le 
parcourt entièrement à l’aide d’une boucle for qui fournit à la fois :

la valeur de chaque élément (item)
sa position dans le tableau (i, l’index)
----------------------------------------------------------------
*/

param items array = ['a', 'b', 'c']


output indexed array = [
  for (item, i) in items: '${i}-${item}'  // Output will be ["0-a", "1-b", "2-c"]
]

/*
Name             Type                       Value
===============  =========================  ==========
indexed          Array                      ["0-a","1-b","2-c"]
*/
