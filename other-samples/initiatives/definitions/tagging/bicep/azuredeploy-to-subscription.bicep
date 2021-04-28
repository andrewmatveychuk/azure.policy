targetScope = 'subscription'

var policySetName = 'tag-governance-psd'
var policySetDisplayName = 'Tag Governance'
var policySetDescription = 'Ensure using specific tags for resources and resource groups'

// Defining the existing policies to reference in the policy set definition
resource policyDefinitionForAuditingResourceTag 'Microsoft.Authorization/policyDefinitions@2020-09-01' existing = {
  name: 'audit-resource-tag-pd'
}
resource policyDefinitionForAuditingResourceTagAndItsFormat 'Microsoft.Authorization/policyDefinitions@2020-09-01' existing = {
  name: 'audit-resource-tag-and-value-format-pd'
}
resource policyDefinitionForAuditingResourceTagAndItsMatch 'Microsoft.Authorization/policyDefinitions@2020-09-01' existing = {
  name: 'audit-resource-tag-and-value-match-pd'
}
resource policyDefinitionForAuditingResourceGroupTag 'Microsoft.Authorization/policyDefinitions@2020-09-01' existing = {
  name: 'audit-resource-group-tag-pd'
}
resource policyDefinitionForAuditingResourceGroupTagAndItsFormat 'Microsoft.Authorization/policyDefinitions@2020-09-01' existing = {
  name: 'audit-resource-group-tag-and-value-format-pd'
}
resource policyDefinitionForAuditingResourceGroupTagAndItsMatch 'Microsoft.Authorization/policyDefinitions@2020-09-01' existing = {
  name: 'audit-resource-group-tag-and-value-match-pd'
}

// Policy set definition aka policy initiative
resource policyInitiative 'Microsoft.Authorization/policySetDefinitions@2020-09-01' = {
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
        policyDefinitionId: subscriptionResourceId('Microsoft.Authorization/policyDefinitions', policyDefinitionForAuditingResourceTagAndItsFormat.name)
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
        policyDefinitionId: subscriptionResourceId('Microsoft.Authorization/policyDefinitions', policyDefinitionForAuditingResourceGroupTagAndItsFormat.name)
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
        policyDefinitionId: subscriptionResourceId('Microsoft.Authorization/policyDefinitions', policyDefinitionForAuditingResourceTag.name)
        policyDefinitionReferenceId: 'Audit a \'Cost Center\' tag is applied to resources'
        parameters: {
          tagName: {
            value: '[parameters(\'costCenterTagName\')]'
          }
        }
      }
      {
        policyDefinitionId: subscriptionResourceId('Microsoft.Authorization/policyDefinitions', policyDefinitionForAuditingResourceGroupTag.name)
        policyDefinitionReferenceId: 'Audit a \'Cost Center\' tag is applied to resource groups'
        parameters: {
          tagName: {
            value: '[parameters(\'costCenterTagName\')]'
          }
        }
      }
      {
        policyDefinitionId: subscriptionResourceId('Microsoft.Authorization/policyDefinitions', policyDefinitionForAuditingResourceTag.name)
        policyDefinitionReferenceId: 'Audit a \'Project\' tag is applied to resources'
        parameters: {
          tagName: {
            value: '[parameters(\'projectTagName\')]'
          }
        }
      }
      {
        policyDefinitionId: subscriptionResourceId('Microsoft.Authorization/policyDefinitions', policyDefinitionForAuditingResourceGroupTag.name)
        policyDefinitionReferenceId: 'Audit a \'Project\' tag is applied to resource groups'
        parameters: {
          tagName: {
            value: '[parameters(\'projectTagName\')]'
          }
        }
      }
      {
        policyDefinitionId: subscriptionResourceId('Microsoft.Authorization/policyDefinitions', policyDefinitionForAuditingResourceTagAndItsFormat.name)
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
        policyDefinitionId: subscriptionResourceId('Microsoft.Authorization/policyDefinitions', policyDefinitionForAuditingResourceGroupTagAndItsFormat.name)
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
        policyDefinitionId: subscriptionResourceId('Microsoft.Authorization/policyDefinitions', policyDefinitionForAuditingResourceTagAndItsMatch.name)
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
        policyDefinitionId: subscriptionResourceId('Microsoft.Authorization/policyDefinitions', policyDefinitionForAuditingResourceGroupTagAndItsMatch.name)
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
