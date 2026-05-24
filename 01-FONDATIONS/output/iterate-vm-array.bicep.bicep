/*
Retourne un tableau identique à l’entrée en itérant sur chaque 
VM sans modifier les valeurs.
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
