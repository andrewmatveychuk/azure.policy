targetScope = 'managementGroup'

var policyName = 'audit-resource-group-tag-and-value-match-pd'
var policyDisplayName = 'Audit a tag and its value match on resource groups'
var policyDescription = 'Audits existence of a tag and its value match. Does not apply to individual resources.'

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
      tagPattern: {
        type: 'String'
        metadata: {
          displayName: 'Tag pattern'
          description: 'An expressions for \'match\' condition'
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
            notMatch: '[parameters(\'tagPattern\')]'
          }
        ]
      }
      then: {
        effect: 'Audit'
      }
    }
  }
}
