/*

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
