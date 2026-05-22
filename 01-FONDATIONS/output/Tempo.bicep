/* 
/*
----------------------------------------------------------------
Par: Alain Laventure
Creer le: 2026-05-01

Description: 

Ce template Bicep déploie une machine virtuelle Windows complète et minimale dans Azure, 
incluant l’ensemble des composants réseau nécessaires à son fonctionnement : une adresse IP publique, 
un groupe de sécurité réseau (NSG), un réseau virtuel avec subnet, une interface réseau et la 
machine virtuelle elle‑même.

L’objectif principal du template est pédagogique, mais surtout orienté vers l’utilisation et la compréhension
 des outputs dans Bicep.

 Après le déploiement, le template expose explicitement, via des outputs, des informations clés générées dynamiquement 
 par Azure :

  l’ID complet de la machine virtuelle
  le nom réel de la VM déployée
  la taille (SKU) de la machine virtuelle
  l’ID de l’adresse IP publique associée

Ces outputs permettent :

d’inspecter les valeurs finales créées par Azure, de valider le déploiement,
et de réutiliser facilement ces informations dans d’autres templates ou scripts (PowerShell, Azure CLI, CI/CD).

En résumé, ce template sert principalement à illustrer comment exposer et exploiter les outputs 
Bicep dans un scénario réel de déploiement de machine virtuelle, tout en conservant une architecture 
simple et compréhensible.

----------------------------------------------------------------

*/

@description('Nom de la machine virtuelle')
param vmName string = 'solSimpleVM'

@description('Emplacement de déploiement des ressources')
param location string = resourceGroup().location

@description('Nom d’utilisateur administrateur pour la VM')
param adminUsername string = 'SolAdmin'

@description('Mot de passe de l’utilisateur administrateur (champ sécurisé)')
@secure()
param adminPassword string

@description('Nom du subnet')
param subnetName string = 'Montreal'

@description('Plage adresse ip pour le subnet')
param mtlSubnet string = '10.0.0.0/24'

@description('Plage adresse IP pour le Vnet')
param solVnetAddressSpace string = '10.0.0.0/16'

@description('Taille de la VM (SKU)')
param vmSize string = 'Standard_DS1_v2'

@description('Éditeur de l’image du système d’exploitation')
param imagePublisher string = 'MicrosoftWindowsServer'

@description('Offre de l’image du système d’exploitation')
param imageOffer string = 'WindowsServer'

@description('SKU de l’image du système d’exploitation')
param imageSku string = '2022-datacenter'

@description('Version de l’image du système d’exploitation')
param imageVersion string = 'latest'

@description('Adresse IP publique pour accéder à la VM')
resource publicIP 'Microsoft.Network/publicIPAddresses@2023-05-01' = {
  name: '${vmName}-pip'
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    publicIPAllocationMethod: 'Dynamic' // L’adresse IP est attribuée dynamiquement
  }
}
@description('Groupe de sécurité réseau avec une règle RDP')
resource nsg 'Microsoft.Network/networkSecurityGroups@2023-05-01' = {
  name: '${vmName}-nsg'
  location: location
  properties: {
    securityRules: [
      {
        name: 'default-allow-rdp'
        properties: {
          priority: 1000 // Priorité de la règle (plus bas = plus prioritaire)
          direction: 'Inbound' // Trafic entrant
          access: 'Allow' // Autoriser le trafic
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3389' // Port RDP
          sourceAddressPrefix: '*' // Toutes les IP sources
          destinationAddressPrefix: '*' // Toutes les IP destinations
        }
      }
    ]
  }
}
@description('Réseau virtuel contenant un subnet avec NSG associé')
resource vnet 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name: '${vmName}-vnet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        solVnetAddressSpace // Plage d’adresses IP du VNet
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: mtlSubnet // Plage d’adresses IP du subnet

          networkSecurityGroup: {
            id: nsg.id // Association du NSG au subnet
          }
        }
      }
    ]
  }
}

@description('Interface réseau connectée au subnet et à l’IP publique')
resource nic 'Microsoft.Network/networkInterfaces@2023-05-01' = {
  name: '${vmName}-nic'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: vnet.properties.subnets[0].id
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIP.id
          }
        }
      }
    ]
  }
}

@description('Machine virtuelle Windows avec disque OS et interface réseau')
resource vm 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize // Taille de la VM
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: imagePublisher
        offer: imageOffer
        sku: imageSku
        version: imageVersion
      }
      osDisk: {
        createOption: 'FromImage' // Crée le disque OS à partir de l’image
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id // Lien avec l’interface réseau
        }
      ]
    }
  }
}

/*Section de la creation des Output*/
output vmID string = vm.id
output vmNameout string = vm.name
output vmImageSKU string = vm.properties.hardwareProfile.vmSize
output publicIP string = publicIP.id

/*


Outputs: 
Name             Type                       Value
===============  =========================  ==========
vmID             String              "/subscriptions/f8d17dee-320f-4765-a0df-a0251ececb1a/ 
                                      resourceGroups/rg-Bicep06/providers/Microsoft.Compute/virtualMachines/solSimpleVM"
vmNameout        String   "solSimpleVM"
vmImageSKU       String   "Standard_DS1_v2"
publicIP         String               "/subscriptions/f8d17dee-320f-4765-a0df-a0251ececb1a/ 
                                       resourceGroups/rg-Bicep06/providers/Microsoft.Network/
                                       publicIPAddresses/solSimpleVM-pip"

*/
