/*

----------------------------------------------------------------
Par: Alain Laventure
Creer le: 2026-04-03
Nom du fichier: Mod-Create-Vm.bicep
#10
Description: Template Bicep de base pour la creation de ressources Azure.

----------------------------------------------------------------

Ce template Bicep déploie automatiquement plusieurs VM Windows, chacune dans un 
subnet distinct, à partir d’un tableau de configuration.

Il crée un NSG (RDP autorisé), un VNet avec subnets dynamiques, 
une IP publique, une NIC et une VM par subnet, le tout dans un 
Resource Group existant.

*/

@description('Location of the resource group where all resources will be deployed')
param rgLocation string = resourceGroup().location

@description('Array of subnet configurations including name and address prefix')
param subnets array   //from the main.bicep we will pass the array of subnets to the module to create the VM in each subnet

@description('Admin username')
param adminUsername string

@description('Admin  password (secure)')
@secure()
param adminPassword string

@description('Name of the NSG')
param nsgName string = 'nsg'

// NSG must be declared before VNet
// 1 nsg est le symbolic nane  
resource nsg 'Microsoft.Network/networkSecurityGroups@2024-07-01' = {
  name: nsgName
  location: rgLocation
  properties: {
    securityRules: [
      {
        name: 'Allow-RDP'
        properties: {
          access: 'Allow'
          direction: 'Inbound'
          priority: 100
          protocol: 'Tcp'
          description: 'Allow Remote Desktop'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}
// VNet avec subnets dynamiv
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
      for subnet in subnets: { // we will loop through the array of subnets that we will pass from the main.bicep to create a subnet for each item in the array
        name: subnet.subnetName // we will use the name of the subnet from the array of subnets that we will pass from the main.bicep
        properties: {
          addressPrefix: subnet.subnetPrefix // we will use the address prefix of the subnet from the array of subnets that we will pass from the main.bicep
          networkSecurityGroup: {
            id: nsg.id // 1 we will associate the NSG that we created earlier with each subnet Index of the NSG in the array of subnets that we will pass from the main.bicep
          }
        }
      }
    ]
  }
}

// IP publique pour chaque VM
//publicIp est le symbolic name de la ressource publicIP
resource publicIP 'Microsoft.Network/publicIPAddresses@2024-05-01' = [
  for (subnet, i) in subnets: {
    name: 'publicIP-${i}' //index of the public IP in the array of subnets that we will pass from the main.bicep
    location: rgLocation
    properties: {
      publicIPAllocationMethod: 'Dynamic'
    }
    sku: {
      name: 'Basic'
      tier: 'Regional'
    }
  }
]

// NIC pour chaque VM
//nic 3 est le symbolic name de la ressource nic
resource nic 'Microsoft.Network/networkInterfaces@2022-07-01' = [
  for (subnet, i) in subnets: { // we will loop through the array of subnets that we will pass from the main.bicep to create a NIC for each item in the array
    name: 'nic-${i}' //index of the NIC in the array of subnets that we will pass from the main.bicep
    location: rgLocation
    properties: {
      ipConfigurations: [
        {
          name: 'ipConfig1'
          properties: {
            privateIPAllocationMethod: 'Dynamic'
            subnet: {
              //id: resourceId('Microsoft.Network/virtualNetworks/subnets', 'solVnet', subnet.subnetName)
              id: Vnet.properties.subnets[i].id // we will use the id of the subnet that we created earlier for each NIC Index of the subnet in the array of subnets that we will pass from the main.bicep
            }
            publicIPAddress: {
              id: publicIP[i].id // 2 we will use the id of the public IP that we created earlier for each NIC Index of the public IP in the array of subnets that we will pass from the main.bicep
            }
          }
        }
      ]
    }
  }
]

// VM Windows pour chaque subnet
resource windowsVM 'Microsoft.Compute/virtualMachines@2020-12-01' = [
  for (subnet, i) in subnets: { // we will loop through the array of subnets that we will pass from the main.bicep to create a VM for each item in the array
    name: subnet.vmName // we will use the name of the VM from the array of subnets that we will pass from the main.bicep
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
          name: 'OSDisk-${i}' //index of the OS disk in the array of subnets that we will pass from the main.bicep
          caching: 'ReadWrite'
          createOption: 'FromImage'
        }
      }
      networkProfile: {
        networkInterfaces: [
          {
            id: nic[i].id // 3 symbolic name de la NIC
          }
        ]
      }
    }
  }
]


