data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "zone-type"
    values = ["availability-zone"]
  }
}
module "vpc" {
  source = "../../modules/vpc"
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  assign_generated_ipv6_cidr_block = false
  system_name = "phong"
  vpc_subnet_count = 3
}

module "eks" {
  source = "../../modules/eks"

  vpc = module.vpc
  cluster_name = "wind-eks-cluster"
  node_name = "wind-nodes"
  ami = "ami-0f0603a9445f57336"
  instance_types = ["t3.medium"]
  domain_name_sub = "be-phong"
  namespace   = var.namespace
  ssh_keypair = var.ssh_keypair
  
}

locals {
  identifier  = "${var.namespace}-db-instance"
  name        = "perntodo"
  user_name   = "postgres"
  port        = 5432
}
module "database" {
  source = "../../modules/database"

  postgres_identifier = local.identifier
  postgres_name  = local.name
  postgres_user_name = local.user_name
  postgres_port = local.port
  vpc = module.vpc
  sg  = module.eks.sg.db

}
