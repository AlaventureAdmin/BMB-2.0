/*
----------------------------------------------------------------
Par: Alain Laventure
Créé le: 2026-04-03

Template Bicep simple utilisé à des fins de test et de démonstration.
Il illustre le déploiement au scope Resource Group (par défaut) et expose un output permettant de valider le contexte d’exécution du template.
Idéal comme point de départ ou pour vérifier le comportement du scope lors des déploiements.

----------------------------------------------------------------
*/

//le scope est resource Group pa default

var message = 'je suis au scope Resource Group'

//output pour visualiser
output result string = message
