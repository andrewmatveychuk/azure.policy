targetScope = 'managementGroup'

var policyName = 'require-owner-tag-pd'
var policyDisplayName = 'Require Owner tag on resources'
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
        field: '[concat(\'tags[\', parameters(\'tagName\'), \']\')]' // For example, 'owner' as the tag name
        notLike: '*@contoso.com' // To match the corporate email address pattern
        // The 'notLike'operator doesn't support multiple wildcards, so '*.*@contoso.com' won't work if you want a pattern like 'Name.Surname@contoso.com'.
      }
      then: {
        effect: '[parameters(\'policyEffect\')]'
      }
    }
  }
}
