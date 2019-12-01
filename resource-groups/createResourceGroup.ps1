# Define the following variables in the deployment pipeline
$deploymentLocation = "West Europe"

#Defining the template and parameter files
$templateFile = ".\resource-groups\azuredeploy.json"
$parameterFile = ".\resource-groups\azuredeploy.parameters.json"

#Initiating the subscription-level deployment of the template
New-AzDeployment -Location $deploymentLocation -TemplateFile $templateFile -TemplateParameterFile $parameterFile -Verbose