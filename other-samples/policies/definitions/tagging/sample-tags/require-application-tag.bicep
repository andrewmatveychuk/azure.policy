targetScope = 'managementGroup'

var policyName = 'require-application-tag-pd'
var policyDisplayName = 'Require Application tag on resources'
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
      policyEffect:{
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
        field: '[concat(\'tags[\', parameters(\'tagName\'), \']\')]' // For example, 'application' as the tag name
        notMatch: '??##-??????????' // To match pattern like 'AC01-FinanceApp'
      }
      then: {
        effect: '[parameters(\'policyEffect\')]'
      }
    }
  }
}
