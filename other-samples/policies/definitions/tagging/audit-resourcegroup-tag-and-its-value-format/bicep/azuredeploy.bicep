targetScope = 'managementGroup'

var policyName = 'audit-resource-group-tag-and-value-format-pd'
var policyDisplayName = 'Audit a tag and its value format on resource groups'
var policyDescription = 'Audits existence of a tag and its value format. Does not apply to individual resources.'

resource policy 'Microsoft.Authorization/policyDefinitions@2020-09-01' = {
  name: policyName
  properties: {
    displayName: policyDisplayName
    description: policyDescription
    policyType: 'Custom'
    mode: 'All'
    metadata: {
      category: 'Tags'
    }

    parameters: {
      tagName: {
        type: 'String'
        metadata: {
          displayName: 'Tag name'
          description: 'A tag to audit'
        }
      }
      tagFormat: {
        type: 'String'
        metadata: {
          displayName: 'Tag format'
          description: 'An expressions for \'like\' condition'
        }
      }
    }

    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Resources/subscriptions/resourceGroups'
          }
          {
            field: '[concat(\'tags[\', parameters(\'tagName\'), \']\')]'
            notLike: '[parameters(\'tagFormat\')]'
          }
        ]
      }
      then: {
        effect: 'Audit'
      }
    }
  }
}
