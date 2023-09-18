terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.28"
    }
  }
}
provider "aws" {
  region = "us-east-2"
}

provider "aws" {
  alias  = "acm_provider"
  region = local.acm_provider_region
}
