/*
---------------------------------------------------------------
Par Alain Laventure
Date: 2024-06-17
Nom du Template : If-expression.bicep
---------------------------------------------------------------

Define condition for deployment

In Bicep, you can conditionally deploy a resource by passing in a 
parameter that specifies if the resource is deployed.

Test the condition with an if expression in the resource declaration.

The following example shows the syntax for an if expression in a Bicep file.

It conditionally deploys a Domain Name System (DNS) zone. When deployZone is true,
 it deploys the DNS zone. When deployZone is false, it skips deploying the DNS zone.

*/

param deployZone bool = true
///param deployZone bool = false

//IF deployZone is false, DNS Zone will not be deployed and the resource will be skipped.
// If deployZone is true, DNS Zone will be deployed.
resource dnsZone 'Microsoft.Network/dnsZones@2018-05-01' = if (deployZone) {
  name:'mZone.com'
  location: 'global'
  }
