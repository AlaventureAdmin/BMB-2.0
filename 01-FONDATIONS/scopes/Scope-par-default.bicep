/*
----------------------------------------------------------------
Par: Alain Laventure
Créé le: 2026-04-03

Template Bicep simple déployé au scope Resource Group (scope par défaut).
Il ne crée aucune ressource et expose uniquement un output permettant de 
confirmer le contexte d’exécution du template.

Utile pour les tests, la compréhension des scopes Bicep ou comme point 
de départ pour des déploiements ciblés au niveau du Resource Group.

----------------------------------------------------------------
*/

//le scope est resource Group pa default

var message = 'je suis au scope Resource Group'

//output pour visualiser
output result string = message

/*
Outputs : 
Name             Type                       Value
===============  =========================  ==========
result           String                     "je suis au scope Resource Group"
*/
