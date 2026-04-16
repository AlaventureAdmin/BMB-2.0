/*
----------------------------------------------------------------
Par: Alain Laventure
Creer le: 2026-04-03

Nom du fichier: .bicep

Description de ce que fait ce template
Ce template Bicep prend un tableau de noms d’utilisateurs et le parcourt 
entièrement à l’aide d’une boucle for qui fournit :

la valeur courante (u, le nom de l’utilisateur)
sa position dans le tableau (i, l’index)

Pour chaque utilisateur, le template construit un objet contenant :

un identifiant numérique (id) basé sur l’index
le nom de l’utilisateur converti en majuscules à l’aide de la fonction toUpper()
----------------------------------------------------------------
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
