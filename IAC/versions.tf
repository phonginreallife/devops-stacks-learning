terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.28"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.1"
    }
  }
  backend "s3" {
    bucket         = "tf-backend-state-phong-trainee"
    key            = "final/production/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "dynamoDB_table_terraform_state"
    encrypt        = true
  }
}