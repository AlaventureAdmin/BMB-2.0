/*
----------------------------------------------------------------
Par: Alain Laventure
Creer le: 2026-04-03

Nom du fichier: .bicep

Description de ce que fait ce template
Ce template Bicep définit un tableau d’objets représentant des machines virtuelles, 
où chaque machine virtuelle possède :

un nom (name)
une taille (size)

Le template parcourt ce tableau d’objets à l’aide d’une boucle for et extrait 
uniquement le nom de chaque machine virtuelle pour produire un tableau de sortie.
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
  for vm in vms: vm.name 
  ]


  /*
Name             Type                       Value
===============  =========================  ==========
size             Array                      ["vm1","vm2"]
  
  */
