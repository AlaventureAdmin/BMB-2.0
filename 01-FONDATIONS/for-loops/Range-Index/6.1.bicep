/*
----------------------------------------------------------------
Par: Alain Laventure
Creer le: 2026-04-03

Nom du fichier: 
Description: Template Bicep de base pour la creation de ressources Azure.

 Description de ce que fait ce template
Ce template Bicep prend un tableau de valeurs en entrée et le parcourt 
intégralement à l’aide d’une boucle for.

Pour chaque élément du tableau :

le template récupère la valeur (item)
ainsi que sa position (index) (i)
puis réécrit la valeur telle quelle dans un nouveau tableau de sortie

Aucune condition n’est appliquée :
tous les éléments du tableau d’origine sont conservés.


----------------------------------------------------------------
*/


param items array = ['a', 'b', 'c']

output indexed array = [
for (item, i) in items: item  // Output will be ["a", "b", "c"]
]

/*
Name             Type                       Value
===============  =========================  ==========
indexed          Array                      ["a","b","c"]
*/
