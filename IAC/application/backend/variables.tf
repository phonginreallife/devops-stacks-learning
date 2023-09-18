variable "namespace" {
  description = "The project namespace to use for unique resource naming"
  type        = string
  default     = "phong-trainee"
}

variable "ssh_keypair" {
  description = "SSH keypair to use for EC2 instance"
  default     = null
  type        = string
}
locals {

  postgres_identifier  = "${var.namespace}-db-instance"
  postgres_name        = "perntodo"
  postgres_user_name   = "postgres"
  postgres_port        = 5432

}