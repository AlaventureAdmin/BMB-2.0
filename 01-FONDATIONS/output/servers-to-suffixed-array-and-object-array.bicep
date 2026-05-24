/*
Génère un tableau de noms de serveurs suffixés avec -srv, puis une version 
équivalente sous forme d’objets.


*/

param servers array = [
  'web'
  'sql'
]


output result1 array = [
for s in servers: '${s}-srv'
]

output result2 array = [
  for s in servers: {
    name: '${s}-srv'
  }
]

/*
Outputs                 :
Name             Type                       Value
===============  =========================  ==========
  result1          Array                      ["web-srv","sql-srv"]
  result2          Array                      [{"name":"web-srv"},{"name":"sql-srv"}]
*/
