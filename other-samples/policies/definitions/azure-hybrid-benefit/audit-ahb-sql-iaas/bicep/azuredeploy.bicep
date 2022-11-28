targetScope = 'managementGroup'

var policyName = 'audit-ahb-sql-server-vm-pd'
var policyDisplayName = 'Azure Hybrid Benefit should be enabled for SQL Server VMs'
var policyDescription = 'Audit if Azure Hybrid Benefit is enabled for SQL Server VMs.'

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
          'Audit'
          'Deny'
          'Disabled'
        ]
        defaultValue: 'Audit'
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
      }
    }
  }
}
