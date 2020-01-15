# azure.policy
Sample ARM templates for Azure policy and policy initiative definitions.

Before starting to work with these templates, read the information in the following blog posts:

* [How to deploy Azure Policies with ARM templates](https://andrewmatveychuk.com/how-to-deploy-azure-policies-with-arm-templates/)

## Build status

[![Build Status](https://dev.azure.com/matveychuk/azure.policy/_apis/build/status/andrewmatveychuk.azure.policy?branchName=master)](https://dev.azure.com/matveychuk/azure.policy/_build/latest?definitionId=3&branchName=master)

## Getting Started

To start working with this project, clone the repository to your local machine and look for the artifacts in the specific folders:

* policies - contains sample ARM templates and deployment scripts for policy definitions and their assignments grouped by logical area
* initiatives - contains sample ARM templates and deployment scripts for policy initiatives and their assignments
* resource-groups - contains the ARM templates and deployment script for a resource group to be used during policy testing

## Build and Test

To create definitions and assignments for policies and initiatives in the target subscription or resource group, use the following build order:

1. Deploy policy definitions

2. Deploy policy initiatives

3. (Optionally) Create a resource group to be used as a target for assignments during testing policy effects

4. Create policy and initiative assignments

## Things to remember

1. Pay attention to the format of parameters as there are cases when they should be provided as an object type. Look into existing policies and initiatives for examples.

2. When using deployment scripts in the build/release pipelines, define the script variables in the pipeline ones.
