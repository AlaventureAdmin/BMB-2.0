/*
----------------------------------------------------------------
Par: Alain Laventure
Creer le: 2026-04-03

Nom du fichier: .bicep

Description de ce que fait ce template
Ce template Bicep définit un tableau représentant des machines virtuelles et
le parcourt à l’aide d’une boucle for qui fournit à la fois :

la valeur de chaque élément (v)
sa position dans le tableau (i)

Pour chaque élément du tableau, le template :

concatène la valeur (v)
avec un numéro séquentiel basé sur l’index, en utilisant i + 1
afin de produire un nom unique pour chaque machine virtuelle

----------------------------------------------------------------
*/

param vms array = ['vm', 'vm', 'vm']


output vmNames array = [
  for (v, i) in vms: '${v}${i+1}'  // Output will be ["vm1", "vm2", "vm3"]
] 

/*
Name             Type                       Value
===============  =========================  ==========
vmNames          Array                      ["vm1", "vm2", "vm3"]
*/
