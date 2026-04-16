/*
----------------------------------------------------------------
Par: Alain Laventure
Creer le: 2026-04-03

Nom du fichier: .bicep

Description de ce que fait ce template
Ce template Bicep définit un tableau d’objets représentant des machines virtuelles.
Chaque objet contient :

un nom (name)
une taille (size)

Le template parcourt ce tableau d’objets à l’aide d’une boucle for et extrait 
uniquement la propriété size de chaque machine virtuelle pour construire un 
tableau de sortie.
----------------------------------------------------------------
*/


param vms array = [
  {
    name: 'vm1'
    size: 'Bs2'
  }
  {
    name: 'vm2'
    size: 'B2ms'
  }
]


output size array = [
  for vm in vms: vm.size 
  ]

  /*
Name             Type                       Value
===============  =========================  ==========
size             Array                      ["Bs2","B2ms"]
  
  */
