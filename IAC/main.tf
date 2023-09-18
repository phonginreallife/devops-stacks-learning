# This is the main running code when you want to create resources using this repo (either use pipeline or terraform apply)
provider "aws" {
  region = var.region
}
# Note: the module application is my custom resources for my final exam application, if you want different architect, you need to 
# custom by youself considering the module i provided at the "modules" repository.

module "frontend" {
  source = "./application/frontend"
}
module "backend" {
  source      = "./application/backend"
}
