output "bucket_name" {
  value = aws_s3_bucket.backendstate.bucket
}
output "db_table_name" {
  value = aws_dynamodb_table.terraform-lock.name
}
output "dynamodb_table_arn" {
  description = "arn of the dynamodb table"
  value       = aws_dynamodb_table.terraform-lock.arn
}
