/*
----------------------------------------------------------------
Par: Alain Laventure
Creer le: 2026-04-03

Nom du fichier: .bicep

Description de ce que fait ce template
Ce template Bicep prend un tableau de noms d’utilisateurs et le parcourt 
entièrement à l’aide d’une boucle for qui fournit :

la valeur courante du tableau (u, le nom de l’utilisateur)
sa position dans le tableau (i, l’index)

Pour chaque utilisateur, le template construit un objet contenant :

le nom de l’utilisateur (name)
un identifiant numérique (id) basé sur son index dans le tableau
----------------------------------------------------------------
*/


param users array = ['alain', 'bob', 'charlie']

output result array = [
  for (u, i) in users: { // Loop through the users array, with u as the current user and i as the index
    name: u
    id: i 
    
  } 
] 

/*

Outputs                 : 
Name             Type                       Value
===============  =========================  ==========
result           Array
[{"name":"alain","id":0},{"name":"bob","id":1},{"name":"charlie","id":2}]
*/
