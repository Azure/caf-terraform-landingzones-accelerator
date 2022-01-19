# Setup the Contoso organization
## Introducing the CAF Terraform framework
It is important to understand from a high-level perspective how the CAF Terraform Framework is working.
The CAF Terraform framework has been designed to minimise the Terraform code you need write in favour of writting an object model that describes your infrastructure services. This data model or configuration is processed by a heavy tested Terraform module to deploy those services.
The main goal of the CAF Terraform framework is to leverage Infrastructure as Data (IaD) instead of Infrastructure as Code (IaC) in order to help our enterprise customers to lower their adoption to IaC by using an open-source, community-driven tested framework they can use by only writting configuration files in yaml or tfvars.

## Organize your private repository
The first step is create a private repository in your current organization. It has to be a git repository.

[instructions]()

## Clone the CAF Terraform starter repository
Clone this repository into your private repository where you are going to host the private attributes of your organization. This repository only contains documentation and configuration and is not meant to be public.

[instructions]()

## Setup the orgs folder
The orgs folder must be created at the root of your private repository. It can host different configuration of your platform landingzones. 
For example, you can setup an engineering and production to represent two master configuration where you can first test the configuration and setting in the engineering platform landingzones and then when validated, move that configuration into the production. This is an approach using a mono-repo but some customers would prefer to have different config git repo to separete engineering from production. More on this topics [here]()

### Copy the demo Contoso configuration
From the starter folder:
- Copy starter/orgs/contoso/multi-subscriptions/platform to orgs/contoso/platform

You can explore the content of this folder and get more details on the files and folders [here]().

### 