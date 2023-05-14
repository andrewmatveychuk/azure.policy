targetScope = 'managementGroup'

var policyName = 'require-createddate-tag-pd'
var policyDisplayName = 'Require Created Date tag on resources'
var policyDescription = 'Audits existence of the tag in a specific format. Does not apply to resource groups.'

resource policy 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
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
      tagPattern: {
        type: 'String'
        metadata: {
          displayName: 'Tag pattern'
          description: 'An expressions for "notMatch" condition'
        }
      }
      policyEffect: {
        type: 'String'
        metadata: {
          displayName: 'Policy effect'
          description: 'Audit or deny resources without the tag'
        }
        allowedValues: [
          'Audit'
          'Deny'
        ]
        defaultValue: 'Audit'
      }
    }

    policyRule: {
      if: {
        field: '[concat(\'tags[\', parameters(\'tagName\'), \']\')]' // For example, 'createdDate' as the tag name
        notMatch: '[parameters(\'tagPattern\')]' // For example '####-##-##' to match '2023-03-16' as a date format
      }
      then: {
        effect: '[parameters(\'policyEffect\')]'
      }
    }
  }
}
