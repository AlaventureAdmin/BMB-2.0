targetScope = 'subscription'

param location string = 'canadacentral'

@secure()
param adminPassword string

resource rg1 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: 'RG1'
  location: location
}

resource rg2 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: 'RG2'
  location: location
}

module rg1Infra './rg1.bicep' = {
  name: 'rg1Infra'
  scope: rg1
  params: {
    location: location
    adminPassword: adminPassword
  }
}

module rg2Infra './rg2.bicep' = {
  name: 'rg2Infra'
  scope: rg2
  params: {
    location: location
    adminPassword: adminPassword
  }
}
``
