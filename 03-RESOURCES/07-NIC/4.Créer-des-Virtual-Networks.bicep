/*
----------------------------------------------------------------
Par: Alain Laventure
Creer le: 2026-04-19

Description: 

----------------------------------------------------------------
*/

var vnets = [
  { name: 'vnet-dev', address: '10.0.0.0/16' }
  { name: 'vnet-prod', address: '10.1.0.0/16' }
]

resource vnet 'Microsoft.Network/virtualNetworks@2023-04-01' = [
  for v in vnets: {
    name: v.name
    location: resourceGroup().location
    properties: {
      addressSpace: {
        addressPrefixes: [
          v.address
        ]
      }
    }
  }
]

/*
2 VNets créés automatiquement

*/
