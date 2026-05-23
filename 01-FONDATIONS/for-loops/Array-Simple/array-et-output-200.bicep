param envs array = [
  'dev'
  'test'
  'prod'  
]

output result1 array = [
for e in envs : e=='dev' ? e : null // Output will be ["", "", "prod"]
]

output result2 array = [
for e in envs : e=='prod' ? e : null // Output will be ["", "", "prod"]
//? = If true  affiche la valeur de e sinon affiche null
]

/*

Outputs                 :
Name             Type                       Value
===============  =========================  ==========
  result1          Array                      ["dev", null, null]
  result2          Array                      [null, null, "prod"]
*/
