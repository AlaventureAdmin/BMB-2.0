/*

Construit une liste d’objets contenant l’index de chaque utilisateur et son nom converti en majuscules.

*/

param users array = ['alain', 'bob', 'charlie']

output result array = [
  for (u, i) in users: { // Loop through the users array, with u as the current user and i as the index
     id: i 
     name: toUpper(u)
  } 
] 

/*
Name             Type                       Value
===============  =========================  ==========
result           Array
[{"id":0,"name":"ALAIN"},{"id":1,"name":"BOB"},{"id":2,"name":"CHARLIE"}]
*/
