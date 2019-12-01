# Define the following variables in the deployment pipeline
$deploymentLocation = "West Europe"

#Creating the array of all template files to use for deployments depending on the specified subscription
[string[]]$definitionFiles = (Get-ChildItem -Path ".\initiatives\definitions\" -File -Filter "azuredeploy.json" -Recurse).FullName
#Removing empty strings from the array if there are any 
$definitionFiles = $definitionFiles | Where-Object {$_}

#Initiating the subscription-level deployment of policy definitions for each template file
$definitionFiles.foreach(
    { 
        New-AzDeployment -Location $deploymentLocation -TemplateFile $_ -Verbose
    }
)