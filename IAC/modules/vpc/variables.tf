locals {
  tag = {
    Env  = "prod-${terraform.workspace}"
  }
  name = "${terraform.workspace}-${var.system_name}"
}
variable "namespace" {
  description = "The project namespace to use for unique resource naming"
  type        = string
  default     = "phong-trainee"
}
variable "cidr_block" {
  type = string
}

variable "instance_tenancy" {
  type = string
}

variable "assign_generated_ipv6_cidr_block" {
  type = bool
}
variable "system_name" {
  type = string
}

variable "vpc_subnet_count" {
  type = number
}
variable "database_subnet_group_name" {
  description = "Name of database subnet group"
  type        = string
  default     = null
}
variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}
variable "database_subnet_group_tags" {
  description = "Additional tags for the database subnet group"
  type        = map(string)
  default     = {}
}
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}