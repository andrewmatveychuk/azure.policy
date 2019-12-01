# Define the following variables in the deployment pipeline
$deploymentLocation = "West Europe"
$resourceGroupName = $null #Or use a resource group name if you want to scope the policy assignments to it
$policyAssignmentMode = "Default" #Or use 'DoNotEnforce' if you only want to test policy effects
$assignedBy = "User Name" # Or use '$env:RELEASE_DEPLOYMENT_REQUESTEDFOR' environment variable if you want to dynamically specify the user who initiated deployment in Azure DevOps release pipeline

#Creating the array of all parameter files to use for deployments depending on the specified subscription
[string[]]$parameterFiles = (Get-ChildItem -Path ".\initiatives\assignments\" -File -Filter "azuredeploy.parameters.json" -Recurse).FullName
#Removing empty strings from the array if there are any 
$definitionFiles = $definitionFiles | Where-Object { $_ }

#Initiating the deployment of policy assignment for each parameter file
$parameterFiles.foreach(
    {
        #Reading a parameter file and creating temporary in-memory hashtable
        $parameterFileText = [System.IO.File]::ReadAllText($_)
        $parameterObject = (ConvertFrom-Json $parameterFileText -AsHashtable).parameters
        
        #Extracting the values of nested 'value' objects to a resulting in-memory hashtable
        if ($parameterObject.initiativeParameters) {
            $rawParameterObject = @{
                initiativeDefinitionName = $parameterObject.initiativeDefinitionName.value
                initiativeAssignmentName = $parameterObject.initiativeAssignmentName.value
                assignedBy               = $assignedBy
                initiativeParameters     = $parameterObject.initiativeParameters.value
            }
        }
        else {
            $rawParameterObject = @{
                initiativeDefinitionName = $parameterObject.initiativeDefinitionName.value
                initiativeAssignmentName = $parameterObject.initiativeAssignmentName.value
                assignedBy               = $assignedBy
            }
        }
        
        #Adding additional deployment parameters from the defined script variables
        $rawParameterObject.Add("policyAssignmentMode", $policyAssignmentMode)
        
        #Conditional template deployment
        if ($resourceGroupName) {
            #Adding resource group name as a deployment parameters if defined in the script variables
            $rawParameterObject.Add("resourceGroupName", $resourceGroupName)
            #Use Resource Group deployment if scoping policy assignment to a specific resource group
            New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile ".\initiatives\assignments\azuredeploy.json" -TemplateParameterObject $rawParameterObject -Verbose 
        }
        else {
            #Use subscription-level deployment if policy assignment is not scoped to a specific resource group
            New-AzDeployment -Location $deploymentLocation -TemplateFile ".\initiatives\assignments\azuredeploy.json" -TemplateParameterObject $rawParameterObject -Verbose
        }
    }
)