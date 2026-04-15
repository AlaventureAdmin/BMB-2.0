/*
----------------------------------------------------------------
Par: Alain Laventure
Créé le: 2026-04-03
#2
Nom du fichier: Scope Subscription (template entier).bicep

Description:
Template Bicep déployé au scope Subscription, servant à illustrer 
et valider le contexte d’exécution à ce niveau. 

Il ne crée aucune ressource, mais expose un output permettant de confirmer 
que le déploiement s’effectue bien au scope subscription.
  
Utile pour les tests, l’apprentissage des scopes Bicep ou comme point de départ avant des déploiements plus avancés.

----------------------------------------------------------------
*/

//Le tempalate est déployé au niveau subscription 
//pour créer des ressources au niveau subscription
targetScope = 'subscription'


//variable pour visual

var message = 'je suis au scope subscription'

//output pour visualiser
output result string = message

/*
Outputs : 
Name             Type                       Value
===============  =========================  ==========
result           String                     "je suis au scope subscription"
*/
