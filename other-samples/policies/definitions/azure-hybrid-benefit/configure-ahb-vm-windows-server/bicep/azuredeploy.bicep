targetScope = 'subscription'

var policyName = 'configure-ahb-vm-windows-server-pd'
var policyDisplayName = 'Configure Azure Hybrid Benefit for Windows Server VMs'
var policyDescription = 'Configures Azure Hybrid Benefit to be enabled for Windows Server VMs.'

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
          'Modify'
          'Disabled'
        ]
        defaultValue: 'Modify'
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
        details: {
          roleDefinitionIds: [
            '/providers/Microsoft.Authorization/roleDefinitions/9980e02c-c2be-4d73-94e8-173b1dc7cf3c'
          ]
          conflictEffect: 'Audit'
          operations: [
            {
              operation: 'addOrReplace'
              field: 'Microsoft.Compute/virtualMachines/licenseType'
              value: 'Windows_Server'
            }
          ]
        }
      }
    }
  }
}
