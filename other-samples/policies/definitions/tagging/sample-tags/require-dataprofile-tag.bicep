targetScope = 'managementGroup'

var policyName = 'require-dataprofile-tag-pd'
var policyDisplayName = 'Require Data Profile tag on resources'
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
      tagAllowedValues:{ // List of allowed tag values
        type: 'Array' // An array of strings in the format like ["internal", "confidential", "restricted"]
        metadata: {
          displayName: 'Tag allowed values'
          description: 'List of allowed options'
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
        field: '[concat(\'tags[\', parameters(\'tagName\'), \']\')]' // For example, 'dataProfile' as the tag name
        notIn: '[parameters(\'tagAllowedValues\')]' // To validate if the tag value is in the provided list of options
      }
      then: {
        effect: '[parameters(\'policyEffect\')]'
      }
    }
  }
}
