# Create the S3 Bucket for the Backend
resource "aws_s3_bucket" "backendstate" {
  bucket              = var.bucket_prefix
  object_lock_enabled = true
}

# S3 Bucket Policy
resource "aws_s3_bucket_public_access_block" "backend-bucket-policy" {
  bucket = aws_s3_bucket.backendstate.id

  block_public_acls   = true
  block_public_policy = true
}

# S3 Server Side Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "s3_server_side_encryption" {
  bucket = aws_s3_bucket.backendstate.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# S3 Versioning, this is highly recomended to have backups.
resource "aws_s3_bucket_versioning" "s3_bucket_versioning" {
  bucket = aws_s3_bucket.backendstate.bucket

  versioning_configuration {
    status = "Enabled"
  }
}