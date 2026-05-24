/*
Filtre une liste d’environnements pour ne conserver que l’entrée prod,
en remplaçant les autres par une chaîne vide.
*/

param envs array = [
  'dev'
  'test'
  'prod'
]

output prodonly array = [
  for e in envs: e == 'prod' ? e : '' // Output will be ["", "", "prod"]
]

/*
Name             Type                       Value
===============  =========================  ==========
prodonly         Array                      ["","","prod"]
*/





