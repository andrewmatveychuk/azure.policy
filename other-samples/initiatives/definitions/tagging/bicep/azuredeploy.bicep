targetScope = 'managementGroup'

@metadata({
  name: 'Target management group'
})
@description('A management group where referenced policy definitions are deployed.')
param targetManagementGroup string

var policySetName = 'tag-governance-psd'
var policySetDisplayName = 'Tag Governance'
var policySetDescription = 'Ensure using specific tags for resources and resource groups'

var policyDefinitionForAuditingResourceTag = 'audit-resource-tag-pd'
var policyDefinitionForAuditingResourceTagAndItsFormat = 'audit-resource-tag-and-value-format-pd'
var policyDefinitionForAuditingResourceTagAndItsMatch = 'audit-resource-tag-and-value-match-pd'
var policyDefinitionForAuditingResourceGroupTag = 'audit-resource-group-tag-pd'
var policyDefinitionForAuditingResourceGroupTagAndItsFormat = 'audit-resource-group-tag-and-value-format-pd'
var policyDefinitionForAuditingResourceGroupTagAndItsMatch = 'audit-resource-group-tag-and-value-match-pd'

resource policy 'Microsoft.Authorization/policySetDefinitions@2020-09-01' = {
  name: policySetName
  properties: {
    displayName: policySetDisplayName
    description: policySetDescription
    policyType: 'Custom'
    metadata: {
      category: 'Tags'
    }

    parameters: {
      ownerTagName: {
        type: 'String'
        metadata: {
          displayName: 'Owner tag name'
          description: 'Tag name to validate'
        }
      }
      ownerTagFormat: {
        type: 'String'
        metadata: {
          displayName: 'Owner tag format'
          description: 'Format for tag value validation (\'like\' condition)'
        }
      }
      costCenterTagName: {
        type: 'String'
        metadata: {
          displayName: 'Cost Center tag name'
          description: 'Tag name to validate'
        }
      }
      projectTagName: {
        type: 'String'
        metadata: {
          displayName: 'Project tag name'
          description: 'Tag name to validate'
        }
      }
      supportTeamTagName: {
        type: 'String'
        metadata: {
          displayName: 'Support Team tag name'
          description: 'Tag name to validate'
        }
      }
      supportTeamTagFormat: {
        type: 'String'
        metadata: {
          displayName: 'Support Team tag format'
          description: 'Format for tag value validation (\'like\' condition)'
        }
      }
      createdDateTagName: {
        type: 'String'
        metadata: {
          displayName: 'Created Date tag name'
          description: 'Tag name to validate'
        }
      }
      createdDateTagPattern: {
        type: 'String'
        metadata: {
          displayName: 'Created Date tag pattern'
          description: 'Pattern to tag validation (\'match\' condition)'
        }
      }
    }

    policyDefinitions: [
      {
        policyDefinitionId: 'Microsoft.Management/managementGroups/${targetManagementGroup}/providers/Microsoft.Authorization/policyDefinitions/${policyDefinitionForAuditingResourceTagAndItsFormat}'
        policyDefinitionReferenceId: 'Audit a valid \'Owner\' tag is applied to resources'
        parameters: {
          tagName: {
            value: '[parameters(\'ownerTagName\')]'
          }
          tagFormat: {
            value: '[parameters(\'ownerTagFormat\')]'
          }
        }
      }
      {
        policyDefinitionId: 'Microsoft.Management/managementGroups/${targetManagementGroup}/providers/Microsoft.Authorization/policyDefinitions/${policyDefinitionForAuditingResourceGroupTagAndItsFormat}'
        policyDefinitionReferenceId: 'Audit a valid \'Owner\' tag is applied to resource groups'
        parameters: {
          tagName: {
            value: '[parameters(\'ownerTagName\')]'
          }
          tagFormat: {
            value: '[parameters(\'ownerTagFormat\')]'
          }
        }
      }
      {
        policyDefinitionId: 'Microsoft.Management/managementGroups/${targetManagementGroup}/providers/Microsoft.Authorization/policyDefinitions/${policyDefinitionForAuditingResourceTag}'
        policyDefinitionReferenceId: 'Audit a \'Cost Center\' tag is applied to resources'
        parameters: {
          tagName: {
            value: '[parameters(\'costCenterTagName\')]'
          }
        }
      }
      {
        policyDefinitionId: 'Microsoft.Management/managementGroups/${targetManagementGroup}/providers/Microsoft.Authorization/policyDefinitions/${policyDefinitionForAuditingResourceGroupTag}'
        policyDefinitionReferenceId: 'Audit a \'Cost Center\' tag is applied to resource groups'
        parameters: {
          tagName: {
            value: '[parameters(\'costCenterTagName\')]'
          }
        }
      }
      {
        policyDefinitionId: 'Microsoft.Management/managementGroups/${targetManagementGroup}/providers/Microsoft.Authorization/policyDefinitions/${policyDefinitionForAuditingResourceTag}'
        policyDefinitionReferenceId: 'Audit a \'Project\' tag is applied to resources'
        parameters: {
          tagName: {
            value: '[parameters(\'projectTagName\')]'
          }
        }
      }
      {
        policyDefinitionId: 'Microsoft.Management/managementGroups/${targetManagementGroup}/providers/Microsoft.Authorization/policyDefinitions/${policyDefinitionForAuditingResourceGroupTag}'
        policyDefinitionReferenceId: 'Audit a \'Project\' tag is applied to resource groups'
        parameters: {
          tagName: {
            value: '[parameters(\'projectTagName\')]'
          }
        }
      }
      {
        policyDefinitionId: 'Microsoft.Management/managementGroups/${targetManagementGroup}/providers/Microsoft.Authorization/policyDefinitions/${policyDefinitionForAuditingResourceTagAndItsFormat}'
        policyDefinitionReferenceId: 'Audit a valid \'Support Team\' tag is applied to resources'
        parameters: {
          tagName: {
            value: '[parameters(\'supportTeamTagName\')]'
          }
          tagFormat: {
            value: '[parameters(\'supportTeamTagFormat\')]'
          }
        }
      }
      {
        policyDefinitionId: 'Microsoft.Management/managementGroups/${targetManagementGroup}/providers/Microsoft.Authorization/policyDefinitions/${policyDefinitionForAuditingResourceGroupTagAndItsFormat}'
        policyDefinitionReferenceId: 'Audit a valid \'Support Team\' tag is applied to resource groups'
        parameters: {
          tagName: {
            value: '[parameters(\'supportTeamTagName\')]'
          }
          tagFormat: {
            value: '[parameters(\'supportTeamTagFormat\')]'
          }
        }
      }
      {
        policyDefinitionId: 'Microsoft.Management/managementGroups/${targetManagementGroup}/providers/Microsoft.Authorization/policyDefinitions/${policyDefinitionForAuditingResourceTagAndItsMatch}'
        policyDefinitionReferenceId: 'Audit a valid \'Created Date\' tag is applied to resources'
        parameters: {
          tagName: {
            value: '[parameters(\'createdDateTagName\')]'
          }
          tagPattern: {
            value: '[parameters(\'createdDateTagPattern\')]'
          }
        }
      }
      {
        policyDefinitionId: 'Microsoft.Management/managementGroups/${targetManagementGroup}/providers/Microsoft.Authorization/policyDefinitions/${policyDefinitionForAuditingResourceGroupTagAndItsMatch}'
        policyDefinitionReferenceId: 'Audit a valid \'Created Date\' tag is applied to resource groups'
        parameters: {
          tagName: {
            value: '[parameters(\'createdDateTagName\')]'
          }
          tagPattern: {
            value: '[parameters(\'createdDateTagPattern\')]'
          }
        }
      }
    ]
  }
}
