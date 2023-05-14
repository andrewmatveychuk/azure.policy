targetScope = 'managementGroup'

var policyName = 'require-documentation-tag-pd'
var policyDisplayName = 'Require Documentation tag on resources'
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
        field: '[concat(\'tags[\', parameters(\'tagName\'), \']\')]' // For example, 'documentation' as the tag name
        notLike: 'https://wiki.contoso.com/*' // To match the URL pattern to an internal Wiki
        // The 'like'operator doesn't support multiple wildcards, so 'https://*.contoso.com/*' won't work.
        // If your internal documentation is spread across different sources, then use 'https://*' as a pattern or provide a few possible patterns using logical operators
      }
      then: {
        effect: '[parameters(\'policyEffect\')]'
      }
    }
  }
}
