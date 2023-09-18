# Terraform Project


## Overview

This repository contains Terraform configurations for provisioning and managing infrastructure resources. The project is organized into modules to facilitate infrastructure as code (IaC) best practices and modularity.

## Table of Contents

- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Modules](#modules)



## Project Structure

- `application/`: Terraform configurations for the application infrastructure.
  - `backend/`: Backend infrastructure modules.
    - main.tf
    - variables.tf
    - outputs.tf
    - providers.tf
  - `frontend/`: Frontkend infrastructure modules.
    - main.tf   
    - variables.tf
    - outputs.tf
    - providers.tf
- `tfbackend/`: Terraform configurations for backend state management.
- `modules/`: Reusable Terraform modules for various components.
    - `database`
    - `eks`
    - `fe-stacks`
    - `vpc`
- `pipeline/`: Terraform configurations for pipeline setup.
- main.tf: Main configurations for the entire project.
- outputs.tf: Terraform output's results.
- variables.tf: Root-level input variable declarations.
- version.tf: Terraform version constraints.


## Prerequisites

Before you can use this Terraform project, you need to have the following prerequisites installed and configured:

- Terraform
- AWS CLI (for AWS provider configurations)
- AWS IAM credentials with appropriate permissions
- Other provider-specific configurations as needed

## Getting Started

Provide step-by-step instructions on how to get started with the project. Include any setup or configuration steps necessary.

1. Clone this repository to your local machine.
   ```bash
   git clone https://git-codecommit.us-west-2.amazonaws.com/v1/repos/IAC-final-exam
2. Change into the project directory.
    ```bash
    cd IAC-final-exam
3. Initialize Terraform in the project directory.
    -  terraform init
4. Review and customize the input variables in terraform.tfvars to match your environment.
    - terraform plan
5. Apply the Terraform configuration to create or update infrastructure resources.
    - terraform apply

## Modules
application/backend
This module manages backend infrastructure components such as databases, storage, and compute resources using eks cluster and ec2 managed node groups.

application/frontend
This module handles frontend infrastructure components, including s3 bucket for static contents, route53 & ssm cert for domain name, and content delivery with cloudfront.

modules/
This directory contains reusable Terraform modules for specific resource types
- `database`
- `eks`
- `fe-stacks`
- `vpc`


