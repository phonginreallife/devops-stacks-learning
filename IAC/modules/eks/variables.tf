variable "namespace" {
  type = string
}
variable "ssh_keypair" {
  type = string
}
variable "ami" {
  default = "ami-0f0603a9445f57336"
}
variable "vpc" {
  type = any
}
# variable "sg" {
#   type = any
# }
variable "cluster_name" {
  type = string
}
variable "node_name" {
  type = string
}
variable "instance_types" {
  type = any
}
variable "domain_name_sub" {
  type = string
}
# variable "hosted_zone_var" {
#   type = string
# }