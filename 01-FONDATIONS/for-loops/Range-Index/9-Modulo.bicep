/*
----------------------------------------------------------------
Par: Alain Laventure
Creer le: 2026-04-03
Nom du fichier: 9-Modulo.bicep

Description: Template Bicep pour démontrer l'utilisation de l'opérateur modulo.
Description du comportement du template
Ce template prend un tableau de valeurs en entrée et parcourt
 chaque élément avec sa position (index).
Pour chaque élément du tableau, le template :

vérifie si sa position (index) est paire ou impaire
conserve la valeur si elle est à une position paire
remplace la valeur par null si elle est à une position impaire

Le résultat final est un nouveau tableau de la même taille que le tableau d’origine, 
où seules les valeurs situées aux index pairs sont gardées.
----------------------------------------------------------------

*/

param values array = [10,20,30]

//modulo operator % returns the remainder of a division operation. 
output evenindex array = [
  for (v, i) in values: (i % 2 == 0) ? v : null   // Output will be [10, null, 30]
]


/*
Name             Type                       Value
===============  =========================  ==========
evenindex        Array                      [10,30]
*/
