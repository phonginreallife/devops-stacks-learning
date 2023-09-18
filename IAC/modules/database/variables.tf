variable "vpc" {
  type = any
}
variable "sg" {
  type = any
}
variable "kms-aws-key" {
  type    = any
  default = "arn:aws:kms:us-west-2:492804330065:key/83551e89-30a6-4cf1-b041-90e1a5bb4778"
}
variable "postgres_identifier" {
  description = "PostgreSQL identifier"
  type        = string
  default     = "identifier"
}

variable "postgres_name" {
  description = "PostgreSQL name"
  type        = string
  default     = "name"
}

variable "postgres_user_name" {
  description = "PostgreSQL username"
  type        = string
  default     = "username"
}

variable "postgres_port" {
  description = "PostgreSQL port"
  type        = number
  default     = 5432  # Replace with your desired port number
}
