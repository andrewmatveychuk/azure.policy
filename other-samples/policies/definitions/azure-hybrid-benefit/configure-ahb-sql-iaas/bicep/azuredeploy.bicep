targetScope = 'subscription'

var policyName = 'configure-ahb-sql-server-vm-pd'
var policyDisplayName = 'Configure Azure Hybrid Benefit for for SQL Server VMs'
var policyDescription = 'Configures Azure Hybrid Benefit to be enabled for for SQL Server VMs.'

resource policy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: policyName
  properties: {
    displayName: policyDisplayName
    description: policyDescription
    policyType: 'Custom'
    mode: 'Indexed'
    metadata: {
      category: 'SQL'
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
    }

    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.SqlVirtualMachine/SqlVirtualMachines'
          }
          {
            field: 'Microsoft.SqlVirtualMachine/SqlVirtualMachines/sqlImageSku'
            in: [
              'Standard'
              'Enterprise'
            ]
          }
          {
            field: 'Microsoft.SqlVirtualMachine/SqlVirtualMachines/sqlServerLicenseType'
            notEquals: 'AHUB'
          }
        ]
      }
      then: {
        effect: '[parameters(\'effect\')]'
        details: {
          roleDefinitionIds: [
            '/providers/Microsoft.Authorization/roleDefinitions/'
          ]
          conflictEffect: 'Audit'
          operations: [
            {
              operation: 'addOrReplace'
              field: 'Microsoft.SqlVirtualMachine/SqlVirtualMachines/sqlServerLicenseType'
              value: 'AHUB'
            }
          ]
        }
      }
    }
  }
}
