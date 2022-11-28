targetScope = 'subscription'

var policyName = 'audit-ahb-vm-windows-server-pd'
var policyDisplayName = 'Azure Hybrid Benefit should be enabled for Windows Server VMs'
var policyDescription = 'Audit if Azure Hybrid Benefit is enabled for Windows Server VMs.'

resource policy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: policyName
  properties: {
    displayName: policyDisplayName
    description: policyDescription
    policyType: 'Custom'
    mode: 'Indexed'
    metadata: {
      category: 'Compute'
    }

    parameters: {
      effect: {
        type: 'String'
        metadata: {
          displayName: 'Effect'
          description: 'Enable or disable the execution of the policy'
        }
        allowedValues: [
          'Audit'
          'Deny'
          'Disabled'
        ]
        defaultValue: 'Audit'
      }
      imageOffers: {
        type: 'Array'
        metadata: {
          displayName: 'Image Offer'
          description: 'OS images eligible for Azure Hybrid Benefit in your environment.'
        }
        defaultValue: [
          'WindowsServer'
        ]
      }
    }

    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Compute/virtualMachines'
          }
          {
            field: 'Microsoft.Compute/imagePublisher'
            equals: 'MicrosoftWindowsServer'
          }
          {
            field: 'Microsoft.Compute/imageOffer'
            in: '[parameters(\'imageOffers\')]'
          }
          {
            field: 'Microsoft.Compute/virtualMachines/licenseType'
            notEquals: 'Windows_Server'
          }
        ]
      }
      then: {
        effect: '[parameters(\'effect\')]'
      }
    }
  }
}
