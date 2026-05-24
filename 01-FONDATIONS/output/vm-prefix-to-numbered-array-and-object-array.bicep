/*

Génère des noms de VM numérotés à partir d’un préfixe, 
sous forme de chaînes simples ou d’objets.

*/

param vms array = [
  'vm'
  'vm'
]


output result1 array = [
  for (vm,i) in vms :'${vm}${i+1}' 
]



output result2 array = [
  for (vm,i) in vms : {
    VmName :'${vm}${i+1}' 
  }
]   

/*

Outputs                 :
Name             Type                       Value
===============  =========================  ==========
  result1          Array                      ["vm1","vm2"]
  result2          Array                      [{"VmName":"vm1"},{"VmName":"vm2"}]
*/
