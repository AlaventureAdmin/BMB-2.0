/*
Retourne un tableau identique à l’entrée en itérant avec un index, 
sans modifier les valeurs.
*/

param items array = ['a', 'b', 'c']

output indexed array = [

  for (item, i) in items: item  // Output will be ["a", "b", "c"]
]

/*
Name             Type                       Value
===============  =========================  ==========
indexed          Array                      ["a","b","c"]
*/
