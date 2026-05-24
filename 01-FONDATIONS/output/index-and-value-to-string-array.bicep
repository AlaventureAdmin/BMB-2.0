/*
Construit un tableau où chaque élément combine son index et
sa valeur sous la forme "index-valeur".
*/

param items array = ['a', 'b', 'c']



output indexed array = [
  for (item, i) in items: '${i}-${item}'  // Output will be ["0-a", "1-b", "2-c"]
]

/*
Name             Type                       Value
===============  =========================  ==========
indexed          Array                      ["0-a","1-b","2-c"]
*/
