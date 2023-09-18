terraform {
  required_version = ">= 1.0.0"
    backend "s3" {
      bucket = "tf-backend-state-phong-trainee"
      key = "pipeline/be/terraform.tfstate"
      region= "us-west-2"
      dynamodb_table = "dynamoDB_table_terraform_state"
      encrypt        = true
     }
}