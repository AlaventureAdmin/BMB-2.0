/*
----------------------------------------------------------------
Par: Alain Laventure
Créé le: 2026-04-03

Nom du fichier: Mod-Create-VM-With-PublicIP-or-whitout-PublicIP.bicep

Description:
Template Bicep permettant de déployer une infrastructure réseau et des machines virtuelles Windows de manière flexible.
Il crée dynamiquement un Network Security Group, un Virtual Network avec plusieurs subnets, ainsi que des VMs Windows, avec la possibilité d’attiver ou non l’attribution d’une Public IP via un simple paramètre.
Le template est conçu pour être facilement réutilisable et extensible selon les besoins de déploiement.
----------------------------------------------------------------
*/

@description('Location of the resource group where all resources will be deployed')
param rgLocation string = resourceGroup().location

@description('Array of subnet configurations')
param subnets array

@description('Admin username')
param adminUsername string

@description('Admin password (secure)')
@secure()
param adminPassword string

@description('Name of the NSG')
param nsgName string = 'nsg'

@description('Enable or disable Public IP on VMs')
param enablePublicIp bool = true

// ------------------------------------------------------------
// Network Security Group
// ------------------------------------------------------------
resource nsg 'Microsoft.Network/networkSecurityGroups@2024-07-01' = {
  name: nsgName
  location: rgLocation
  properties: {
    securityRules: [
      {
        name: 'Allow-RDP'
        properties: {
          priority: 100
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          description: 'Allow Remote Desktop'
        }
      }
    ]
  }
}

// ------------------------------------------------------------
// Virtual Network + Subnets dynamiques
// ------------------------------------------------------------
resource Vnet 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: 'solVnet'
  location: rgLocation
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.144.0.0/20'
      ]
    }
    subnets: [
      for subnet in subnets: {
        name: subnet.subnetName
        properties: {
          addressPrefix: subnet.subnetPrefix
          networkSecurityGroup: {
            id: nsg.id
          }
        }
      }
    ]
  }
}

// ------------------------------------------------------------
// Public IP (créée UNIQUEMENT si enablePublicIp = true)
// ------------------------------------------------------------
resource publicIP 'Microsoft.Network/publicIPAddresses@2024-05-01' = [
  for (subnet, i) in subnets: if (enablePublicIp) {
    name: 'publicIP-${i}'
    location: rgLocation
    sku: {
      name: 'Basic'
      tier: 'Regional'
    }
    properties: {
      publicIPAllocationMethod: 'Dynamic'
    }
  }
]

// ------------------------------------------------------------
// Network Interface Cards (NIC)
// ------------------------------------------------------------
resource nic 'Microsoft.Network/networkInterfaces@2022-07-01' = [
  for (subnet, i) in subnets: {
    name: 'nic-${i}'
    location: rgLocation
    properties: {
      ipConfigurations: [
        {
          name: 'ipConfig1'
          properties: {
            privateIPAllocationMethod: 'Dynamic'
            subnet: {
              id: Vnet.properties.subnets[i].id
            }

            // Public IP conditionnelle
            publicIPAddress: enablePublicIp ? {
              id: publicIP[i].id
            } : null
          }
        }
      ]
    }
  }
]

// ------------------------------------------------------------
// Windows Virtual Machines
// ------------------------------------------------------------
resource windowsVM 'Microsoft.Compute/virtualMachines@2020-12-01' = [
  for (subnet, i) in subnets: {
    name: subnet.vmName
    location: rgLocation
    properties: {
      hardwareProfile: {
        vmSize: 'Standard_A2_v2'
      }
      osProfile: {
        computerName: subnet.vmName
        adminUsername: adminUsername
        adminPassword: adminPassword
      }
      storageProfile: {
        imageReference: {
          publisher: 'MicrosoftWindowsServer'
          offer: 'WindowsServer'
          sku: '2019-Datacenter'
          version: 'latest'
        }
        osDisk: {
          name: 'OSDisk-${i}'
          createOption: 'FromImage'
          caching: 'ReadWrite'
        }
      }
      networkProfile: {
        networkInterfaces: [
          {
            id: nic[i].id
          }
        ]
      }
    }
  }
]

