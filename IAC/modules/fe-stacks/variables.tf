variable "bucket_prefix" {
  type        = string
  description = "The prefix for the S3 bucket"
  default     = "tf-phong-fe"
}
variable "sub_domain_name" {
  type        = string
  description = "The sub domain name to use with hosted zone"
}
variable "domain_name" {
  type        = string
  description = "The sub domain name to use with hosted zone"
}
variable "hosted_zone_var" {
  type    = any
  default = "devops-training.opswat.com"
}
