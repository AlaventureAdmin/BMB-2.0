/*
----------------------------------------------------------------
Par: Alain Laventure
Creer le: 2026-04-03

Nom du fichier: .bicep


Description de ce que fait ce template
Ce template Bicep définit un tableau contenant des noms de machines virtuelles et le parcourt entièrement à l’aide d’une boucle for.
Pour chaque élément du tableau :

le template récupère la valeur (v)
ainsi que sa position dans le tableau (i)
puis retranscrit uniquement la valeur, sans utiliser l’index pour la modifier
----------------------------------------------------------------
*/

param vms array = ['vm', 'vm', 'vm']


output vmNames array = [
  for (v, i) in vms: v  // Output will be ["vm", "vm", "vm"]
] 

/*
Name             Type                       Value
===============  =========================  ==========
vmNames          Array                      ["vm", "vm", "vm"]
*/
