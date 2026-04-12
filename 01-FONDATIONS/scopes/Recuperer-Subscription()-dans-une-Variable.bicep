/*
----------------------------------------------------------------
Par: Alain Laventure
Créé le: 2026-04-03

Nom du fichier: Mod-Create-VM-With-PublicIP-or-whitout-PublicIP.bicep

Description:
Template Bicep déployé au scope Subscription permettant de récupérer et d’exposer l’identifiant de la souscription Azure en cours.
Il est principalement utilisé à des fins de test, de validation du scope ou comme base pour des scénarios nécessitant l’ID de la subscription 
(chaînage de modules, déploiements conditionnels, automatisation).
----------------------------------------------------------------
*/


targetScope = 'subscription'

// Récupère l’ID de la subscription
var subId = subscription().subscriptionId

output result string = subId


/*
Outputs                 : 
Name             Type                       Value
===============  =========================  ==========
result           String                     "f8d17dee-320f-4765-a0df-a0251ececb1a"

*/
