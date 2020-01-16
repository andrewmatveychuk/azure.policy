# azure.policy
Sample ARM templates for Azure policy and policy initiative definitions.

Before starting to work with these templates, read the information in the following blog posts according to your points of interest:

* [How to deploy Azure Policies with ARM templates](https://andrewmatveychuk.com/how-to-deploy-azure-policies-with-arm-templates/)
* [Using ARM templates to deploy Azure Policy initiatives](https://andrewmatveychuk.com/using-arm-templates-to-deploy-azure-policy-initiatives/)
* [How to enforce naming convention for Azure resources](https://andrewmatveychuk.com/how-to-enforce-naming-convention-for-azure-resources/)
* [Automatic tagging for Azure resources](https://andrewmatveychuk.com/automatic-tagging-for-azure-resources/)
* [How to ensure proper configuration for your Azure resources](https://andrewmatveychuk.com/how-to-ensure-proper-configuration-for-your-azure-resources/)

## Build status

[![Build Status](https://dev.azure.com/matveychuk/azure.policy/_apis/build/status/andrewmatveychuk.azure.policy?branchName=master)](https://dev.azure.com/matveychuk/azure.policy/_build/latest?definitionId=3&branchName=master)

## Getting Started

To start working with this project, clone the repository to your local machine and look for the artifacts in the specific folders:

* linked templates - contains sample ARM templates for policy and initiative definitions plus their assignments grouped by logical area
* main-template - contains master ARM template to perform deployments of all policies and initiatives to a subscription

## Build and Test

To create definitions and assignments for policies and initiatives in the target subscription or resource group, use the following build order:

1. Deploy policy definitions

2. Deploy policy initiatives

3. (Optionally) Create a resource group to be used as a target for assignments during testing policy effects

4. Create policy and initiative assignments

## Things to remember

1. Pay attention to the format of parameters as there are cases when they should be provided as an object type. Look into existing policies and initiatives for examples.

2. When using deployment scripts in the build/release pipelines, define the script variables in the pipeline ones.
