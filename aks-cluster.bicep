@description('The name of the Managed Cluster resource.')
param clusterName string = 'dev-aks'

@description('The location of the Managed Cluster resource.')
param location string = resourceGroup().location

@description('Optional DNS prefix to use with hosted Kubernetes API server FQDN.')
param dnsPrefix string = 'devg'

@description('Disk size (in GB) to provision for each of the agent pool nodes. This value ranges from 0 to 1023. Specifying 0 will apply the default disk size for that agentVMSize.')
@minValue(0)
@maxValue(1023)
param osDiskSizeGB int = 0

@description('The number of nodes for the cluster.')
@minValue(1)
@maxValue(50)
param agentCount int = 1

@description('The size of the Virtual Machine.')
param agentVMSize string = 'standard_B2s'

@description('User name for the Linux Virtual Machines.')
param linuxAdminUsername string = 'devn'

@description('Configure all linux machines with the SSH RSA public key string. Your key should include three parts, for example \'ssh-rsa AAAAB...snip...UcyupgH azureuser@linuxvm\'')
param sshRSAPublicKey string = 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCsCJipeVD8kWBiNbK0Sffp27LozjMMfRjcNtVTG1rc8u6F7ArgTY/Y7Ik3kXwi+uEeAoo2quvs1n++P0YEAbkCRgbw/v8LlP7tjp2XwBWF52KpfwwI4nUDYRe4nNDUOyi3CUo4uzi68YqpLCroCynMwRdtkV+ra2yj9pzbZ/cu01iN04mQRR2fEkztKpmQQmvsKsMDhM9sH835z8jrubU+NkSucd2n4sBabitprzuHpZeIhGMroWtZ7rd5Ow8j3pWVtmp88eqZWX5J8NpB99+8exMVR1dxFR20Y1qjvFuRmvYjEnSenTOw6t0m4F7bkwsWifFBsE8fBDcOQkayIs4RLGh9MH9A8xO9YT3bY+1ZfEY2uS+eaiUoLkz3OGeYEqp2/t1fjwt3P78L17O5sPYP+IsPyOPhBhMj+IJXgm6XDOubwSbBbWVzPLRufl/2DBhEXzgCr8MTZPP9imqZF3WklY2ANxzljfnc3bVk7C8pMu/ElUCoaCLH5q5eMeVw0tEt9jS5JdyrsOhzc+udOc8IhaU0NInJtmPwv6ljvhcXA3GNbB8AafDx8Rm+KTOj6J8Lvs4I++WsJz4qt1g4A8OjluO/Oj5jYK/XMBmMs+TfDsf1RiLVkrpiKgwkXDBHms0pFEAQHs/+H1wQfICFRVfADxZCqB72MiTsiRh8D72t7Q== devan@dev-vm'

resource aks 'Microsoft.ContainerService/managedClusters@2024-02-01' = {
  name: clusterName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    dnsPrefix: dnsPrefix
    agentPoolProfiles: [
      {
        name: 'devagent'
        osDiskSizeGB: osDiskSizeGB
        count: agentCount
        vmSize: agentVMSize
        osType: 'Linux'
        mode: 'System'
      }
    ]
    linuxProfile: {
      adminUsername: linuxAdminUsername
      ssh: {
        publicKeys: [
          {
            keyData: sshRSAPublicKey
          }
        ]
      }
    }
  }
}

output controlPlaneFQDN string = aks.properties.fqdn






// @description('Location for the AKS Cluster')
// param location string = 'centralindia'

// @description('Name of the AKS cluster')
// param clusterName string = 'myAksCluster'

// @description('DNS prefix for the AKS API server')
// param dnsPrefix string = 'myaksdns'

// @description('Node count')
// param agentCount int = 2

// @description('VM size for the node pool')
// param vmSize string = 'Standard_DS2_v2'

// resource aks 'Microsoft.ContainerService/managedClusters@latest' = {
//   name: clusterName
//   location: location
//   identity: {
//     type: 'SystemAssigned'
//   }
//   properties: {
//     dnsPrefix: dnsPrefix
//     kubernetesVersion: '' // Use latest available
//     enableRBAC: true
//     agentPoolProfiles: [
//       {
//         name: 'nodepool1'
//         count: agentCount
//         vmSize: vmSize
//         osType: 'Linux'
//         type: 'VirtualMachineScaleSets'
//         mode: 'System'
//       }
//     ]
//     networkProfile: {
//       networkPlugin: 'azure'
//     }
//   }
// }

// output controlPlaneFQDN string = aks.properties.fqdn
