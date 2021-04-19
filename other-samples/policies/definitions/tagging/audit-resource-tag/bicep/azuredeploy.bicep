targetScope = 'managementGroup'

var policyName = 'audit-resource-tag-pd'
var policyDisplayName = 'Audit a tag on resources'
var policyDescription = 'Audits existence of a tag. Does not apply to resource groups.'

resource policy 'Microsoft.Authorization/policyDefinitions@2020-09-01' = {
  name: policyName
  properties: {
    displayName: policyDisplayName
    description: policyDescription
    policyType: 'Custom'
    mode: 'Indexed'
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
    }

    policyRule: {
      if: {
        field: '[concat(\'tags[\', parameters(\'tagName\'), \']\')]'
        exists: false
      }
      then: {
        effect: 'Audit'
      }
    }
  }
}
