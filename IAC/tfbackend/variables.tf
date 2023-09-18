
variable "region" {
  description = "AWS region Eg: us-east-2"
  type        = string
  default     = "us-east-2"
}
variable "bucket_prefix" {
  type        = string
  description = "The prefix for the S3 bucket"
  default     = "tf-backend-state-phong-trainee"
}