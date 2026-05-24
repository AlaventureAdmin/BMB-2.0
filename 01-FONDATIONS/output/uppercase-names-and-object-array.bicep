/*
Produit soit un tableau de noms en majuscules, soit un tableau
d’objets { name: <MAJUSCULE> } à partir d’une liste de noms
*/

param names array = [
  'vm1'
  'vm2'
]


output result2 array = [ // Output will be [{"name":"VM1"},{"name":"VM2"}]
 for name in names:toUpper(name)
 ]

output result1 array = [ // Output will be [{"name":"VM1"},{"name":"VM2"}]
 for name in names: {
  name: toUpper(name)
 
 }
]

/*
Outputs                 :
Name             Type                       Value
===============  =========================  ==========
  result1          Array                      [{"name":"VM1"},{"name":"VM2"}]
  result2          Array                      ["VM1","VM2"]
  */
