# Pipeline

The pipeline/ directory contains Terraform configurations for setting up a pipeline to automate the deployment of infrastructure changes.

## Prerequisites

Before you can use this Terraform project, you need to have the following prerequisites installed and configured:

- Terraform
- AWS CLI (for AWS provider configurations)
- AWS IAM credentials with appropriate permissions
- A terraform code repository which you want to apply ci/cd pipeline. 
- Other provider-specific configurations as needed

## Getting Started

Provide step-by-step instructions on how to get started with the project. Include any setup or configuration steps necessary.

1. Clone this repository to your local machine.
   ```bash
   git clone https://git-codecommit.us-west-2.amazonaws.com/v1/repos/IAC-final-exam
2. Change into the project directory.
    ```bash
    cd IAC-final-exam/pipeline
3. Initialize Terraform in the project directory.
    -  terraform init
4. Review and customize the input variables in terraform.tfvars to match your environment.
    - terraform plan
5. Apply the Terraform configuration to create or update infrastructure resources.
    - terraform apply